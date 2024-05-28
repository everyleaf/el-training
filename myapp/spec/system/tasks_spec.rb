# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Tasks', type: :system do
  before do
    @task = Task.create!(title: 'test task title', details: 'test task description')
  end

  it 'create task' do
    visit new_task_path

    fill_in 'task_title', with: 'task title'
    fill_in 'task_details', with: 'task description'

    click_button 'Create'

    expect(page).to have_content 'タスク登録に成功しました。'
  end

  it 'create task error' do
    visit new_task_path

    fill_in 'task_details', with: 'task description'

    click_button 'Create'

    expect(page).to have_content 'タスク登録に失敗しました。'
  end
end
