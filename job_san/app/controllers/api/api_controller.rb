# frozen_string_literal: true
module Api
  class ApiController < ActionController::API
    include ActionController::Cookies
    include SessionsHelper

    private

    def logged_in_user
      render status: :unauthorized, json: {} unless logged_in?
    end
  end
end
