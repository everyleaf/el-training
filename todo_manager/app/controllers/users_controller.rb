class UsersController < ApplicationController
  before_action :forbid_login_user, {only: %i(new create login login_post)}

  def login
  end

  def login_post
    @user = User.find_by(name: params[:name])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      flash[:notice] = I18n.t('flash.users.login.success')
      redirect_to('/')
    else
      @error_message = I18n.t('flash.users.login.failure')
      render('users/login')
    end
  end

  def logout
    session[:user_id] = nil
    flash[:notice] = I18n.t('flash.users.logout')
    redirect_to('/login')
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(name: params[:name], password: params[:password])
    if @user.save
      session[:user_id] = @user.id
      flash[:notice] = I18n.t('flash.users.signup')
      redirect_to('/')
    else
      render('users/new')
    end
  end
end
