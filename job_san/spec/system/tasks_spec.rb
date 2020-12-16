# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Task, type: :system do
  let(:sample_task_name) { 'やらなきゃいけないサンプル' }
  let!(:sample_task) { create(:task, name: sample_task_name) }

  describe '#index' do
    it 'visit index page' do
      visit tasks_path
      p page
      expect(page).to have_content sample_task_name
    end
  end
end
