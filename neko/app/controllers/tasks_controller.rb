class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]

  def index
    @tasks = Task.all
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)

    if @task.save
      flash[:success] = I18n.t('flash.succeeded', target:'タスク', action:'作成')
      redirect_to tasks_path
    else
      flash.now[:danger] = I18n.t('flash.failed', target:'タスク', action:'作成')
      render :new
    end
  end

  def show; end

  def edit; end

  def update
    if @task.update(task_params)
      flash[:success] = I18n.t('flash.succeeded', target:'タスク', action:'更新')
      redirect_to task_path(@task)
    else
      flash.now[:danger] = I18n.t('flash.failed', target:'タスク', action:'更新')
      render :edit
    end
  end

  def destroy
    if @task.destroy
      flash[:success] = I18n.t('flash.succeeded', target:'タスク', action:'削除')
      redirect_to tasks_path
    else
      flash.now[:danger] = I18n.t('flash.failed', target:'タスク', action:'削除')
      render :show
    end
  end

  private

  def set_task
    @task = Task.find(params[:id])
  end

  def task_params
    params.require(:task).permit(:name, :description)
  end
end
