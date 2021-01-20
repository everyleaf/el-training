# frozen_string_literal: true

class SessionsController < ApplicationController
  before_action :logged_in?, except: %i[new create]

  def new
  end

  def create
    user = User.find_by(email: params[:email])
    if user&.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to root_url, success: I18n.t('flash.login_success', user: user.name)
    else
      flash.now[:danger] = I18n.t('flash.login_error')
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path, success: I18n.t('flash.logout_success')
  end

  # private
  # def session_params
  #   params.require(:user).permit(:email, :password)
  # end
end
