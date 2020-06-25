class ApplicationController < ActionController::Base
  rescue_from Exception, with: :render500
  rescue_from ActionController::RoutingError, with: :render404
  rescue_from ActiveRecord::RecordNotFound, with: :render404

  def render404(exception = nil)
    logger.error "404 error: #{exception.message}" if exception
    render 'errors/404', status: :not_found
  end

  def render500(exception = nil)
    logger.error "500 error: #{exception.message}" if exception
    render 'errors/500', status: :internal_server_error
  end
end
