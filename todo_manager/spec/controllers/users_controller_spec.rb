require 'rails_helper'

RSpec.describe UsersController, type: :controller do

  describe "GET #login" do
    it "returns http success" do
      get :login
      expect(response).to have_http_status(200)
    end
  end

  describe "GET #new" do
    it "returns http success" do
      get :new
      expect(response).to have_http_status(200)
    end
  end

end
