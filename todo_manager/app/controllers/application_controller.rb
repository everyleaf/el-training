class ApplicationController < ActionController::Base
  include ApplicationHelper

  unless Rails.env.development?
    rescue_from Exception, with: :_render_500
    rescue_from ActiveRecord::RecordNotFound, with: :_render_404
    rescue_from ActionController::RoutingError, with: :_render_404
  end

  def _render_404
    render template: 'errors/404', status: 404, layout: false, content_type: 'text/html'
  end

  def _render_500
    render template: 'errors/500', status: 500, layout: false, content_type: 'text/html'
  end

  def authenticate_user
    if current_user.nil?
      flash[:notice] = I18n.t('flash.users.login.must')
      redirect_to('/login')
    end
  end

  def forbid_login_user
    if current_user
      flash[:notice] = I18n.t('flash.users.login.already')
      redirect_to('/')
    end
  end
end
