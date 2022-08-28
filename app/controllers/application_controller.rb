class ApplicationController < ActionController::Base
  include SessionsHelper

  # ユーザがログインしているか確認
  def logged_in_user
    return if logged_in?

    flash[:danger] = I18n.t 'login_required'
    redirect_to login_url
  end
end
