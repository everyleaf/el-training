# frozen_string_literal: true

class TasksController < ApplicationController
  include TaskHelper

  before_action :logged_in_user

  SORT_KEY = 'target_date'

  def index
    @query = current_user.tasks.includes(:labels).ransack(params[:query])
    @labels = Label.all
    @tasks = @query.result.order(created_at: :desc).page params[:page]
  end

  def show
    @task = current_user.tasks.includes(:labels).find_by(id: params[:id])
  end

  def new
    @task = Task.new
    @labels = Label.all
  end

  def create
    @task = current_user.tasks.new(task_params.except(:attach_labels))
    @task = TaskService.new(@task).create_task(task_params)
    @errors = @task.errors
    return redirect_to tasks_path, notice: I18n.t('view.task.flash.created') if @errors.blank?

    flash.now[:alert] = I18n.t('view.task.flash.not_created')
    render new_task_path
  end

  def edit
    @task = current_user.tasks.eager_load(:labels).find_by(id: params[:id])
    @labels = Label.all
    redirect_to tasks_path, notice: I18n.t('view.task.error.not_found') unless @task
  end

  def update
    @task = current_user.tasks.find_by(id: params[:id])
    redirect_to tasks_path, notice: I18n.t('view.task.error.not_found') unless @task

    @task = TaskService.new(@task).update_task(task_params)
    @errors = @task.errors
    return redirect_to task_url(id: params[:id]), notice: I18n.t('view.task.flash.updated') if @errors.blank?

    @labels = Label.all
    flash.now[:alert] = I18n.t('view.task.flash.not_updated')
    render :edit
  end

  def destroy
    task = current_user.tasks.find_by(id: params[:id])
    return redirect_to tasks_path, notice: I18n.t('view.task.error.not_found') if task.blank?

    task.destroy
    redirect_to tasks_path, notice: I18n.t('view.task.flash.deleted')
  end

  private

  def task_params
    params.require(:task).permit(:name, :description, :target_date, :status, { attach_labels: [] })
  end
end
