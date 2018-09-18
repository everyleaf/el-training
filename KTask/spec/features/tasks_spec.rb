require 'rails_helper'

RSpec.feature "Tasks", :type => :feature do
  scenario "新しいタスクを作成" do
    visit "/tasks/new"
    click_button "Create Task"
    expect(page).to have_text('Task was successfully created.')
  end
end
