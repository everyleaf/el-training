# frozen_string_literal: true

require 'rails_helper'

RSpec.feature 'Tasks', type: :feature do
  scenario '新しいタスクを作成' do
    expect do
      visit root_path
      click_link '作成'
      fill_in 'Title', with: 'First content'
      fill_in 'Content', with: 'Rspec test'
      click_button 'Create Tasks'
      expect(page).to have_text('Task was successfully create.')
      expect(page).to have_text('First content')
    end

    expect do
    end
  end
end
