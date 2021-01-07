# frozen_string_literal: true

module SessionsHelper
  SIGN_IN_COOKIES = %i[user_id remember_token].freeze

  def log_in(user)
    session[:user_id] = user.id
  end

  def remember(user)
    user.remember
    cookies.permanent.signed[:user_id] = user.id
    cookies.permanent[:remember_token] = user.remember_token
  end

  def forget(user)
    user.forget
    SIGN_IN_COOKIES.each { |key| cookies.delete(key) }
  end

  def current_user
    return @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
    return unless (user_id = cookies.signed[:user_id])

    user = User.find_by(id: user_id)
    return unless user&.authenticated?(cookies[:remember_token])

    log_in user
    @current_user = user
  end

  def logged_in?
    !current_user.nil?
  end

  def log_out
    forget(current_user)
    session.delete(:user_id)
    @current_user = nil
  end
end
