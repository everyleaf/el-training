# frozen_string_literal: true

module Admin
  class UsersController < ApplicationController
    def index
      @query = User.ransack(params[:query])
      @users = @query.result.order(created_at: :desc).page params[:page]
    end

    def new
      @user = User.new
    end

    def create
      @user = User.new(user_params)
      if @user.save
        redirect_to admin_users_path, notice: I18n.t('view.task.flash.created')
      else
        @errors = @user.errors
        flash.now[:alert] = I18n.t('view.task.flash.not_created')
        render new_admin_user_path
      end
    end

    def edit
      @user = User.find_by(id: params[:id])
      redirect_to admin_users_path, notice: I18n.t('view.task.error.not_found') unless @user
    end

    def update
      @user = User.find_by(id: params[:id])
      redirect_to admin_users_path, notice: I18n.t('view.task.error.not_found') unless @user

      if @user.update(user_params)
        flash[:notice] = I18n.t('view.task.flash.updated')
        redirect_to admin_users_path
      else
        @errors = @user.errors
        flash.now[:alert] = I18n.t('view.task.flash.not_updated')
        render :edit
      end
    end

    def user_tasks
      @query = Task.ransack(params[:query])
      @tasks = @query.result.where(user_id: params[:id]).order(created_at: :desc).page params[:page]
    end

    def destroy
      user = User.find_by(id: params[:id])
      return redirect_to admin_users_path, notice: I18n.t('view.task.error.not_found') unless user

      if user.destroy
        redirect_to admin_users_path, notice: I18n.t('view.task.flash.deleted')
      else
        @errors = user.errors
        flash.now[:alert] = I18n.t('view.task.flash.not_deleted')
        render admin_users_path
      end
    end

    private

    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end
  end
end
