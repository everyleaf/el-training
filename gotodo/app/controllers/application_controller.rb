# frozen_string_literal: true

class ApplicationController < ActionController::Base
  add_flash_types :success, :info, :warning, :danger

  before_action :logged_in?
  def logged_in?
    redirect_to login_path if current_user.nil?
  end

  helper_method :current_user
  def current_user
    User.find_by(id: session[:user_id]) if session[:user_id]
  end
end
