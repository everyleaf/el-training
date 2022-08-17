require 'rails_helper'

RSpec.describe 'Admins', type: :request do
  describe 'GET /index' do
    it 'returns http success' do
      get '/admin/index'
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET /show' do
    it 'returns http success' do
      get '/admin/show'
      expect(response).to have_http_status(:success)
    end
  end
end
