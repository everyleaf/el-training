# frozen_string_literal: true

class Admin::UsersController < ApplicationController
  before_action :set_user, only: %i[show destroy]
  before_action :login_check

  def index
    user_sort_params
    @users = User.users_with_tasks_count
                 .sorted(sort: params[:sort], direction: params[:direction])
                 .page(params[:page])
                 .per(10)
  end

  def show
  end

  def new
  end

  def edit
  end

  def create
  end

  def update
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

  def user_sort_params
    params.permit(:sort, :direction)
  end
end
