# frozen_string_literal: true

require 'rails_helper'

RSpec.feature 'Tasks', type: :feature do
  scenario '新しいタスクを作成' do
    expect do
      visit root_path
      click_link '作成'
      fill_in 'Title', with: 'First content'
      fill_in 'Content', with: 'Rspec test'
      click_button 'Create Task'
      expect(page).to have_content('Task was successfully create.')
      expect(page).to have_content('First content')
      expect(page).to have_content('Rspec test')
    end.to change { Task.count }.by(1)
  end

  scenario 'タスクの修正' do
    visit root_path
    click_link '作成'
    fill_in 'Title', with: 'Before modify'
    fill_in 'Content', with: 'Rspec test'
    click_button 'Create Task'
    expect do
      click_link 'Edit'
      fill_in 'Title', with: 'After modify'
      fill_in 'Content', with: 'Sleepy morning'
      click_button 'Update Task'
      expect(page).to have_content 'Task was successfully updated.'
      expect(page).to have_content 'After modify'
      expect(page).to have_content 'Sleepy morning'
    end.to change { Task.count }.by(0)
  end

  scenario 'タスクの削除' do
    visit root_path
    click_link '作成'
    fill_in 'Title', with: 'Delete Test'
    fill_in 'Content', with: 'Delete this'
    click_button 'Create Task'
    expect do
      click_link '削除'
      expect(page).to have_content 'Task was successfully destroyed.'
    end.to change { Task.count }.by(-1)
  end
end
