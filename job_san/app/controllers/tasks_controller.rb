# frozen_string_literal: true

class TasksController < ApplicationController
  include TaskHelper

  before_action :logged_in_user

  SORT_KEY = 'target_date'

  def index
    # TODO: ステップ14までページネーションは実装しません。
    @query = current_user.tasks.ransack(params[:query])
    @tasks = @query.result.order(created_at: :desc).page params[:page]
  end

  def show
    @task = current_user.tasks.find_by(id: params[:id])
  end

  def new
    @task = Task.new
  end

  def create
    @task = current_user.tasks.new(task_params)
    if @task.save
      redirect_to tasks_path, notice: I18n.t('view.task.flash.created')
    else
      @errors = @task.errors
      flash.now[:alert] = I18n.t('view.task.flash.not_created')
      render new_task_path
    end
  end

  def edit
    @task = current_user.tasks.find_by(id: params[:id])
    redirect_to tasks_path, notice: I18n.t('view.task.error.not_found') unless @task
  end

  def update
    @task = current_user.tasks.find_by(id: params[:id])
    redirect_to tasks_path, notice: I18n.t('view.task.error.not_found') unless @task

    @task = TaskService.new(@task).update_task(task_params)
    @errors = @task.errors
    if @errors.blank?
      flash[:notice] = I18n.t('view.task.flash.updated')
      redirect_to task_url id: params[:id]
    else
      flash.now[:alert] = I18n.t('view.task.flash.not_updated')
      render :edit
    end
  end

  def destroy
    task = current_user.tasks.find_by(id: params[:id])
    return redirect_to tasks_path, notice: I18n.t('view.task.error.not_found') if task.blank?

    if task.destroy
      redirect_to tasks_path, notice: I18n.t('view.task.flash.deleted')
    else
      @errors = task.errors
      flash.now[:alert] = I18n.t('view.task.flash.not_deleted')
      render tasks_path
    end
  end

  private

  def task_params
    params.require(:task).permit(:name, :description, :target_date, :status)
  end
end
