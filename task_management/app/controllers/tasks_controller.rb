class TasksController < ApplicationController
  before_action :set_task, only: %i[show edit update destroy]

  def index
    @tasks = Task.all.order(created_at: :desc)
  end

  def show
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)
    @task.save if redirect_to tasks_path, notice: I18n.t('tasks.flash.create')
  end

  def edit
  end

  def update
    @task.update(task_params) if redirect_to tasks_path, notice: I18n.t('tasks.flash.update')
  end

  def destroy
    @task.destroy if redirect_to tasks_path, notice: I18n.t('tasks.flash.destroy')
  end

  private

  def task_params
    params.require(:task).permit(:title, :priority, :status, :due, :description)
  end

  def set_task
    @task = Task.find(params[:id])
  end
end
