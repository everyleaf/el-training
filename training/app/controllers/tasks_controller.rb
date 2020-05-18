class TasksController < ApplicationController
  before_action :set_task, only: %i[show edit update destroy]

  def index
    @tasks = Task.all
  end

  def show; end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(tasks_params)
    if @task.save
      redirect_to tasks_path, notice: 'タスクが作成されました'
    else
      render :new
    end
  end

  def edit; end

  def update
    if @task.update(tasks_params)
      redirect_to tasks_path, notice: 'タスクが更新されました'
    else
      render :edit
    end
  end

  def destroy
    @task.destroy!
    redirect_to tasks_path, notice: 'タスクが削除されました'
  end

  private

  def tasks_params
    params.require(:task).permit(:title, :description, :priority, :status, :due_date)
  end

  def set_task
    @task = Task.find(params[:id])
  end
end
