class TasksController < ApplicationController
  def index
    @tasks = Task.all
  end

  def show
    @task = Task.find_by(id: params[:id])
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)

    # TODO: ステップ11までバリデーションは実装しません。
    if @task.save
      redirect_to tasks_path, notice: 'タスクを作成したよ'
    else
      flash.now[:alert] = 'タスクが作成できなかったよ'
      render new_task_path
    end
  end

  def edit
    @task = Task.find_by(id: params[:id])
    redirect_to tasks_path, notice: 'そのタスクないよ' unless @task
  end

  def update
    @task = Task.find_by(id: params[:id])
    redirect_to tasks_path, notice: 'そのタスクないよ' unless @task

    # TODO: ステップ11までバリデーションは実装しません。
    if @task.update(task_params)
      flash[:notice] = 'タスクを更新したよ'
      redirect_to task_url id: params[:id]
    else
      flash.now[:alert] = 'タスクが更新できなかったよ'
      render edit_task_url
    end
  end

  def destroy
    task = Task.find_by(id: params[:id])
    redirect_to tasks_path, notice: 'そのタスクないよ' unless task

    task.destroy
    redirect_to tasks_path, notice: 'タスクを削除したよ'
  end

  private

  def task_params
    params.require(:task).permit(:name, :description)
  end
end
