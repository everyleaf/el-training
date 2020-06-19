class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]

  def index
    @tasks = Task.all
  end

  def show
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)
    @task.save if redirect_to tasks_path, notice: 'タスクが登録されました'
  end

  def edit
  end

  def update
    @task.update(task_params) if redirect_to tasks_path, notice: 'タスクが編集されました'
  end

  def destroy
    @task.destroy if redirect_to tasks_path, notice: 'タスクを削除しました'
  end

  private

  def task_params
    params.require(:task).permit(:title, :priority, :status, :due, :description)
  end

  def set_task
    @task = Task.find(params[:id])
  end
end
