# frozen_string_literal: true

class TasksController < ApplicationController
  before_action :set_task, only: %i[show edit update destroy]

  def index
    raise
    @tasks = Task.all
  end

  def show
  end

  def new
    @task = Task.new
  end

  def edit
  end

  def create
    @task = Task.new(task_params)
    if @task.save
      redirect_to @task, notice: t('flash.create_success', model: t('activerecord.models.task'))
    else
      flash.now[:alert] = t('flash.create_success', model: t('activerecord.models.task'))
      render :new
    end
  end

  def update
    if @task.update(task_params)
      redirect_to @task, notice: t('flash.update_success', model: t('activerecord.models.task'))
    else
      flash.now[:alert] = t('flash.create_success', model: t('activerecord.models.task'))
      render :edit
    end
  end

  def destroy
    @task.destroy
    redirect_to tasks_url, notice: t('flash.destroy_success', model: t('activerecord.models.task'))
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_task
    @task = Task.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def task_params
    params.require(:task).permit(:task_name, :detail)
  end
end
