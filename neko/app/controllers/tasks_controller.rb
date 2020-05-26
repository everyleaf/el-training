class TasksController < ApplicationController
  helper_method :sort_column, :sort_direction
  before_action :set_task, only: [:show, :edit, :update, :destroy]
  before_action :set_statuses, only: [:index, :new, :edit, :edit]

  def index
    @search = { name: params[:name], status_id: params[:status_id] }
    @tasks = Task.search(@search).rearrange(sort_column, sort_direction)
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)
    trunc_sec_due_at

    if @task.save
      flash[:success] = I18n.t('flash.succeeded', target: 'タスク', action: '作成')
      redirect_to tasks_path
    else
      flash.now[:danger] = I18n.t('flash.failed', target: 'タスク', action: '作成')
      statuses_all
      render :new
    end
  end

  def show; end

  def edit; end

  def update
    trunc_sec_due_at

    if @task.update(task_params)
      flash[:success] = I18n.t('flash.succeeded', target: 'タスク', action: '更新')
      redirect_to task_path(@task)
    else
      flash.now[:danger] = I18n.t('flash.failed', target: 'タスク', action: '更新')
      statuses_all
      render :edit
    end
  end

  def destroy
    if @task.destroy
      flash[:success] = I18n.t('flash.succeeded', target: 'タスク', action: '削除')
      redirect_to tasks_path
    else
      flash.now[:danger] = I18n.t('flash.failed', target: 'タスク', action: '削除')
      render :show
    end
  end

  private

  def set_statuses
    @statuses = Status.all.order(phase: :asc)
  end

  def set_task
    @task = Task.find(params[:id])
  end

  def task_params
    params.require(:task).permit(:name, :description, :due_at, :have_a_due, :status_id)
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : 'desc'
  end

  def sort_column
    Task.column_names.include?(params[:sort]) ? params[:sort] : 'created_at'
  end

  def trunc_sec_due_at
    @task.due_at = Time.zone.at(Time.current.to_i / 60 * 60) if @task.due_at.nil?
  end
end
