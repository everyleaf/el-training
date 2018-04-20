require 'rails_helper'

RSpec.describe "Todos", type: :request do
  describe "Check Home (index) page" do
    it "should have the content 'Todo List'" do
      get '/'
      expect(page).to have_content('Todo List')
    end
  end
end
