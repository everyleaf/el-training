# frozen_string_literal: true

class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:session][:email])
    if user&.authenticate(params[:session][:password])
      log_in user
      params[:session][:remember_me] == '1' ? remember(user) : forget(user)
      redirect_to tasks_path
    else
      flash.now[:danger] = I18n.t('view.session.flash.login.invalid_param')
      render :new
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to login_path
  end
end
