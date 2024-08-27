class ErrorsController < ApplicationController
  rescue_from StandardError, with: :internal_server_error
  rescue_from ActiveRecord::RecordNotFound, with: :not_found

  def not_found
    redirect_to "/errors/404"
  end

  def internal_server_error
    redirect_to "/errors/500"
  end

  def show
    @status_code = params[:status]
    status_codes = Rack::Utils::HTTP_STATUS_CODES

    if status_codes.key?(@status_code.to_i)
      @msg = status_codes[@status_code.to_i]
    else
      @status_code = ""
      @msg = "Unknown Error Occurred"
    end

    render template: "errors/status_error", layout: "error"
  end
end

Rails.application.configure do
  config.exceptions_app = ErrorsController.action(:show)
end
