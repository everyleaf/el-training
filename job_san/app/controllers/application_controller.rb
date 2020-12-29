# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include SessionsHelper

  unless Rails.env.development?
    rescue_from Exception, with: :render_500
    rescue_from ActionController::RoutingError, with: :render_404
  end

  def render_404
    render 'errors/404', status: :not_found
  end

  private

  def render_500(err = nil)
    logger.error "Rendering 500 with exception: #{err&.message}"
    render 'errors/500', status: :internal_server_error
  end

  def logged_in_user
    redirect_to login_url unless logged_in?
  end
end
