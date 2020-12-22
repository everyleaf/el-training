# frozen_string_literal: true

class TasksController < ApplicationController
  def index
    # TODO: ステップ14までページネーションは実装しません。
    @tasks = Task.all.order(created_at: :desc)
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
      redirect_to tasks_path, notice: I18n.t('view.task.flash.created')
    else
      @errors = @task.errors
      flash.now[:alert] = I18n.t('view.task.flash.not_created')
      render new_task_path
    end
  end

  def edit
    @task = Task.find_by(id: params[:id])
    redirect_to tasks_path, notice: I18n.t('view.task.error.not_found') unless @task
  end

  def update
    @task = Task.find_by(id: params[:id])
    redirect_to tasks_path, notice: I18n.t('view.task.error.not_found') unless @task

    # TODO: ステップ11までバリデーションは実装しません。
    if @task.update(task_params)
      flash[:notice] = I18n.t('view.task.flash.updated')
      redirect_to task_url id: params[:id]
    else
      @errors = @task.errors
      flash.now[:alert] = I18n.t('view.task.flash.not_updated')
      render :edit
    end
  end

  def destroy
    task = Task.find_by(id: params[:id])
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
    params.require(:task).permit(:name, :description)
  end
end
