class ApplicationController < ActionController::Base
  # 例外発生時のルーティング設定
  rescue_from Exception,                      with: :_render_500
  rescue_from ActionController::RoutingError, with: :_render_404

  def routing_error
    raise ActionController::RoutingError, params[:path]
  end

  private

  def _render_404(error = nil)
    Rails.logger.debug { "Rendering 404 with excaption: #{error}" } if error
    render('errors/404.html', status: :not_found)
  end

  def _render_500(error = nil)
    Rails.logger.debug { "Rendering 500 with excaption: #{error}" } if error
    render('errors/500.html', status: :internal_server_error)
  end
end
