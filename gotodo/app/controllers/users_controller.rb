# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :set_user, only: %i[show edit update destroy]
  before_action :login_check, except: %i[new create]

  def index
    @users = User.all
  end

  def show
  end

  def new
    @user = User.new
  end

  def edit
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to root_path, success: I18n.t('flash.create_success', model: I18n.t('activerecord.models.user'))
    else
      flash.now[:danger] = I18n.t('flash.create_error', model: I18n.t('activerecord.models.user'))
      render :new
    end
  end

  def update
    if @user.update(user_params)
      redirect_to @user, success: I18n.t('flash.update_success', model: I18n.t('activerecord.models.user'))
    else
      flash.now[:danger] = I18n.t('flash.update_error', model: I18n.t('activerecord.models.user'))
      render :edit
    end
  end

  def destroy
    @user.destroy
    redirect_to root_url, success: I18n.t('flash.destroy_success', model: I18n.t('activerecord.models.user'))
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = User.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
