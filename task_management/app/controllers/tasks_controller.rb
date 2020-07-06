class TasksController < ApplicationController
  helper_method :sort_column, :sort_direction

  before_action :set_task, only: %i[show edit update destroy]

  def index
    @tasks = Task.all.order("#{sort_column} #{sort_direction}")
  end

  def show
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)
    if @task.save
      redirect_to tasks_path, notice: I18n.t('tasks.flash.create')
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @task.update(task_params)
      redirect_to tasks_path, notice: I18n.t('tasks.flash.update')
    else
      render :edit
    end
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

  def sort_direction
    %w(asc desc).include?(params[:direction]) ? params[:direction] : 'desc'
  end

  def sort_column
    Task.column_names.include?(params[:sort]) ? params[:sort] : 'created_at'
  end
end
