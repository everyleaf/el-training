# frozen_string_literal: true

module Api
  class SessionsController < Api::ApiController
    include SessionsHelper

    def destroy
      log_out if logged_in?
      render json: {}
    end
  end
end
