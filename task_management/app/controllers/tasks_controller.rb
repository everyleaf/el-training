class TasksController < ApplicationController

  def index
    @tasks = Task.all
  end

  def show
    @task = Task.find(params[:id])
  end

  def new
    @task = Task.new 
  end
  
  def create
    @task = Task.new(task_params)
    if @task.save
      redirect_to tasks_path, notice: 'タスクが登録されました'
    end
  end

  def edit
    @task = Task.find(params[:id]) 
  end
  
  def update
    @task = Task.find(params[:id])
    if @task.update(task_params)
      redirect_to tasks_path, notice: 'タスクが編集されました'
    end
  end  

  def destroy
    @task = Task.find(params[:id])
    if @task.destroy
      redirect_to tasks_path, notice: 'タスクを削除しました'
    end
  end

  private

  def task_params
    params.require(:task).permit(:title, :priority, :status, :due, :description)
  end

end
