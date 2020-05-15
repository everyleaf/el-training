class TasksController < ApplicationController
  helper_method :sort_column, :sort_direction
  before_action :set_task, only: [:show, :edit, :update, :destroy]
  before_action :statuses_all, only: [:index, :new, :edit, :edit]
  PER = 20

  def index
    @search = { name: params[:name], status: search_status }
    @tasks = if sort_column == 'due_at'
               Task.search(@search).order(have_a_due: :desc).order(sort_column + ' ' + sort_direction).page(params[:page]).per(PER)
             elsif sort_column == 'status_id'
               Task.search(@search).includes(:status).order('statuses.phase ' + sort_direction).page(params[:page]).per(PER)
             else
               Task.search(@search).order(sort_column + ' ' + sort_direction).page(params[:page]).per(PER)
             end
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)

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

  def statuses_all
    @statuses = Status.all.order(phase: :asc)
  end

  def search_status
    Status.where(id: params[:status_id]).exists? ? params[:status_id] : nil
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
end
