# frozen_string_literal: true

class TasksController < ApplicationController
  TASK_CREATED = 'タスクを作成したよ'
  TASK_NOT_CREATED = 'タスクが作成できなかったよ'
  TASK_NOT_FOUND = 'そのタスクないよ'
  TASK_UPDATED = 'タスクを更新したよ'
  TASK_NOT_UPDATED = 'タスクが更新できなかったよ'
  TASK_DELETED = 'タスクを削除したよ'
  TASK_NOT_DELETED = 'タスクが削除できなかったよ'

  def index
    # TODO: ステップ14までページネーションは実装しません。
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
      redirect_to tasks_path, notice: TASK_CREATED
    else
      flash.now[:alert] = TASK_NOT_CREATED
      render new_task_path
    end
  end

  def edit
    @task = Task.find_by(id: params[:id])
    redirect_to tasks_path, notice: TASK_NOT_FOUND unless @task
  end

  def update
    @task = Task.find_by(id: params[:id])
    redirect_to tasks_path, notice: TASK_NOT_FOUND unless @task

    # TODO: ステップ11までバリデーションは実装しません。
    if @task.update(task_params)
      flash[:notice] = TASK_UPDATED
      redirect_to task_url id: params[:id]
    else
      flash.now[:alert] = TASK_NOT_UPDATED
      render edit_task_url
    end
  end

  def destroy
    task = Task.find_by(id: params[:id])
    redirect_to tasks_path, notice: TASK_NOT_FOUND unless task

    if task.destroy
      redirect_to tasks_path, notice: TASK_DELETED
    else
      flash.now[:alert] = TASK_NOT_DELETED
      render tasks_path
    end
  end

  private

  def task_params
    params.require(:task).permit(:name, :description)
  end
end
