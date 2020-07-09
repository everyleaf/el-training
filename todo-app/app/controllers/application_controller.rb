class ApplicationController < ActionController::Base

  unless Rails.configuration._use_original_error_screen_
    rescue_from StandardError, with: :rescue500
    rescue_from ActionController::RoutingError, with: :rescue404

    def routing_error
      raise ActionController::RoutingError, params[:path]
    end


    private

    def rescue500(e = nil)
      logger.error "Rendering 500 with exception: #{e.message}" if e
      render "errors/internal_server_error", status: 500
    end

    def rescue404(e = nil)
      logger.info "Rendering 404 with exception: #{e.message}" if e
      render "errors/not_found", status: 404
    end

  else
    def routing_error(e = nil)
      raise e if e
    end
  end

end
