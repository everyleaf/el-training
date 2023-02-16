class ApplicationController < ActionController::Base
    private

    rescue_from Exception, with: :render_500
    rescue_from ActiveRecord::RecordNotFound, with: :render_404
    rescue_from ActionController::RoutingError, with: :render_404
  
    def render_404
        render file: 'public/404.html', status: 404, layout: false, content_type: 'text/html'
    end

    def render_500
        render file: 'public/500.html', status: 500, layout: false, content_type: 'text/html'
    end
end
