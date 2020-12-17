# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Task, type: :system do
  let(:sample_task_name) { 'やらなきゃいけないサンプル' }
  let!(:sample_task) { create(:task, name: sample_task_name) }

  describe '#index' do
    it 'visit index page' do
      visit tasks_path
      expect(page).to have_content sample_task_name
    end
  end

  describe '#new' do
    before { visit new_task_path }

    context 'submit valid values' do
      let(:sample_task_name) { 'これから作るタスクの名前' }
      let(:sample_task_description) { 'これから作るタスクの説明文' }
      before do
        fill_in 'Name', with: sample_task_name
        fill_in 'Description', with: sample_task_description
      end

      subject { click_button 'Create Task' }

      it 'move to task list page' do
        subject
        expect(current_path).to eq tasks_path
        expect(page).to have_content TasksController::TASK_CREATED
      end

      it 'create new task' do
        expect { subject }.to change(Task, :count).by(1)
      end
    end
  end
end
