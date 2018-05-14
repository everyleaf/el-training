class ApplicationController < ActionController::Base
  include ApplicationHelper

  def authenticate_user
    if current_user.nil?
      flash[:notice] = I18n.t('flash.users.login.must')
      redirect_to('/login')
    end
  end

  def forbid_login_user
    if current_user
      flash[:notice] = I18n.t('flash.users.login.already')
      redirect_to('/')
    end
  end
end
