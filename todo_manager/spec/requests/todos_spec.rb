require 'rails_helper'

RSpec.describe "Todos", type: :request do
  describe "GET /" do
    it "works! (now write some real specs)" do
      get '/'
      expect(response).to have_http_status(200)
    end
  end
end
