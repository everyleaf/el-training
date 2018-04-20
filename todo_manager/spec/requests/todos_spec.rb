require 'rails_helper'

RSpec.describe "Todos", type: :request do
  describe "Home (index) page" do
    it "should have the content 'Todo List'" do
      visit '/'
      expect(page).to have_content('Todo List')
    end
  end

  describe "new page" do
    it "should have the content 'Todo List'" do
      visit '/todos/new'
      expect(page).to have_content('Create Todo')
    end
  end

  describe "detail page" do
    it "should have the title and content of the todo" do
      todo = create(:todo)
      visit "/todos/#{todo.id}/detail"
      expect(page).to have_content('Sample title')
      expect(page).to have_content('Sample content')
    end
  end

end
