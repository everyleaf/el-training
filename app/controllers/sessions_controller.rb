class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      flash[:success] = 'login_success'
      redirect_to user
    else
      flash.now[:danger] = 'invalid_login'
      render 'new', status: :unprocessable_entity
    end
  end

  def destroy
  end
end
