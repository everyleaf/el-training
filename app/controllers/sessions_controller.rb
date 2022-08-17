class SessionsController < ApplicationController
  def new
    return unless logged_in?

    redirect_to tasks_url
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      if user.activated
        log_in user
        flash[:success] = I18n.t 'login_success'
        redirect_to tasks_url

      else
        flash[:warning] = I18n.t 'please_activate'
        redirect_to root_url
      end

    else
      flash.now[:danger] = I18n.t 'invalid_login_information'
      render 'new', status: :unprocessable_entity
    end
  end

  def destroy
    log_out
    redirect_to root_url
  end
end
