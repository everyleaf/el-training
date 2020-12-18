# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ApplicationController, type: :system do
  context 'occur internal server error' do
    before { allow(Task).to receive(:all).and_raise(RuntimeError) }

    it 'render custom 500' do
      get tasks_path
      expect(response).to have_http_status :internal_server_error
      expect(response.body).to have_content 'そのアクセスはちょっと待って！'
    end
  end

  context 'access not routed path' do
    it 'render custom 404' do
      get "/#{SecureRandom.uuid}"
      expect(response).to have_http_status :not_found
      expect(response.body).to have_content 'そんなページないです。'
    end
  end
end
