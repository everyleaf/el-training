class AccountActivationsController < ApplicationController
  def edit
    user = User.find_by(email: params[:email])
    if user && !user.activated && user.authenticated?(params[:id])

      user.activate
      flash[:info] = I18n.t 'user_create_success'
      Category.create(name: '未分類', user:)
      log_in user
      redirect_to tasks_url
    else
      flash[:danger] = I18n.t 'invalid_activation_link'
      redirect_to root_url
    end
  end
end
