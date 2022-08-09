class ApplicationController < ActionController::Base
  include SessionsHelper

  # ユーザがログインしているか確認
  def logged_in_user
    unless logged_in?
      flash[:danger] = "Please Login"
      redirect_to login_url
    end
  end
end
