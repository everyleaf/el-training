class TasksController < ApplicationController
  def index
    @tasks = Task.all
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.create(task_params)

    if @task.save
      flash[:success] = 'タスクを作成しました'
      redirect_to tasks_path
    else
      flash.now[:danger] = 'タスクの作成に失敗しました'
      render :new
    end
  end

  def show
    @task = Task.find(params[:id])
  end

  def edit
    @task = Task.find(params[:id])
  end

  def update
    @task = Task.find(params[:id])

    if @task.update(task_params)
      flash[:success] = 'タスクを更新しました'
      redirect_to task_path(@task)
    else
      flash.now[:danger] = 'タスクの更新に失敗しました'
      render :edit
    end
  end

  def destroy
    @task = Task.find(params[:id])

    if @task.destroy
      flash[:success] = 'タスクを削除しました'
      redirect_to tasks_path
    else
      flash.now[:danger] = 'タスクの削除に失敗しました'
      render :show
    end
  end

  private

  def task_params
    params.require(:task).permit(:name, :description)
  end
end
