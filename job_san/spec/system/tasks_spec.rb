# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Task, type: :system do
  let(:sample_task_name) { 'やらなきゃいけないサンプル' }
  let!(:sample_task) { create(:task, name: sample_task_name) }

  describe '#index' do
    it 'visit index page' do
      visit tasks_path
      expect(page).to have_content sample_task.name
    end
  end

  describe '#show' do
    it 'visit show page' do
      visit task_path id: sample_task.id
      expect(page).to have_content sample_task.name
    end
  end

  describe '#new' do
    before { visit new_task_path }

    context 'submit valid values' do
      let(:create_task_name) { 'これから作るタスクの名前' }
      let(:create_task_description) { 'これから作るタスクの説明文' }
      before do
        fill_in 'Name', with: create_task_name
        fill_in 'Description', with: create_task_description
      end

      subject { click_button '登録する' }

      it 'move to task list page' do
        subject
        expect(current_path).to eq tasks_path
        expect(page).to have_content I18n.t('view.task.flash.created')
      end

      it 'create new task' do
        expect { subject }.to change(Task, :count).by(1)
      end
    end
  end

  describe '#edit' do
    before { visit edit_task_path id: sample_task.id }

    context 'submit valid values' do
      let(:update_task_name) { '更新するタスクの名前' }
      let(:update_task_description) { '更新するタスクの説明文' }
      before do
        fill_in 'Name', with: update_task_name
        fill_in 'Description', with: update_task_description
      end

      subject { click_button '更新する' }

      it 'move to task list page' do
        subject
        expect(current_path).to eq task_path id: sample_task.id
        expect(page).to have_content I18n.t('view.task.flash.updated')
      end

      it 'update selected task' do
        expect { subject }.to change { Task.find(sample_task.id).name }.from(sample_task_name).to(update_task_name)
      end
    end
  end

  describe '#destroy' do
    before { visit task_path id: sample_task.id }

    subject { click_on '削除' }

    it 'move to task list page' do
      subject
      expect(current_path).to eq tasks_path
      expect(page).to have_content I18n.t('view.task.flash.deleted')
    end

    it 'delete selected task' do
      expect { subject }.to change(Task, :count).by(-1)
    end
  end
end
