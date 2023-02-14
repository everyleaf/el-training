require 'rails_helper'

RSpec.describe "Tasks", type: :request do
  describe "GET /index" do
    let(:tasks) { create_list(:task, 10) }

    it 'renders a successful response' do
      get tasks_url
      expect(response).to have_http_status(:ok)
    end
  end

  describe 'GET /new' do
    it 'renders a successful response' do
      get new_task_url
      expect(response).to have_http_status(:ok)
    end
  end

  describe 'GET /edit' do
    it 'renders a successful response' do
      get edit_task_url
      expect(response).to have_http_status(:ok)
    end
  end


end