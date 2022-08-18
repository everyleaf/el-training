class ApplicationController < ActionController::Base
    def render_404
        render template: 'errors/error_404', status: 404, layout: 'application', content_type: 'text/html'
    end

    def render_500
        render template: 'errors/error_500', status: 500, layout: 'application', content_type: 'text/html'
    end
end
