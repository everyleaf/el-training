class ApplicationController < ActionController::Base
  private
  
  add_flash_types :success, :info, :warning, :danger
  rescue_from Exception, with: :render_500
  rescue_from ActiveRecord::RecordNotFound, with: :render_404
  rescue_from ActionController::RoutingError, with: :render_404

  def render_404(e = nil)
    logger.error "Rendering 404 with excaption: #{e.message}" if e
    
    if request.format.to_sym == :json
      render json: { error: '404 Not Found' }, status: :not_found
    else
      render file: 'public/404.html', status: 404, layout: false, content_type: 'text/html'
    end
  end

  def render_500(e = nil)
    logger.error "Rendering 500 with excaption: #{e.message}" if e

    if request.format.to_sym == :json
      render json: { error: '500 Internal Server Error' }, status: :internal_server_error
    else
      render file: 'public/404.html', status: 404, layout: false, content_type: 'text/html'
    end
  end
end
