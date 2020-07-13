# frozen_string_literal: true

class ApplicationController < ActionController::Base
  if Rails.configuration._use_original_error_screen_
    def routing_error(exception = nil)
      raise exception if exception
    end
  else
    rescue_from StandardError, with: :rescue500
    rescue_from ActionController::RoutingError, with: :rescue404
    rescue_from RecordNotFound, with: :rescue404

    def routing_error
      raise ActionController::RoutingError, params[:path]
    end

    private

    def rescue500(exception = nil)
      logger.error "Rendering 500 with exception: #{exception.message}" if exception
      render 'errors/internal_server_error', status: 500
    end

    def rescue404(exception = nil)
      logger.info "Rendering 404 with exception: #{exception.message}" if exception
      render 'errors/not_found', status: 404
    end
  end
end
