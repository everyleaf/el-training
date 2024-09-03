# TaskController is a controller to handle basic CRUD operations for "task"
class TasksController < ApplicationController
  def index
    sort_param = params[:sort].to_s.downcase
    case sort_param
    when 'due_date_at'
      sort = sort_param
    else
      sort = 'created_at'
    end
    # TODO: support ascending
    sort += ' DESC'

    @new_task = Task.new
    @tasks = Task.order(sort)
  end

  def show
    @task = Task.find_by(id: params[:id])
    @status_map = get_status_map
    redirect_to error_path(404) if @task.nil?
  end

  def create
    data = task_data(params)
    @task = Task.new(data)
    if @task.save
      flash[:success] = I18n.t 'msg_create_success'
      redirect_to root_path
    else
      flash.now[:danger] = I18n.t 'msg_create_failure'

      @new_task = @task
      @tasks = Task.order('created_at DESC')
      render :index, status: :unprocessable_entity
    end
  end

  def edit
    @task = Task.find_by(id: params[:id])
    redirect_to error_path(404) if @task.nil?

    @status_map = get_status_map
  end

  def update
    @task = Task.find_by(id: params[:id])
    redirect_to error_path(404) if @task.nil?

    data = task_data(params)
    if @task.update(data)
      flash[:success] = I18n.t 'msg_update_success'
      redirect_to root_path
    else
      flash.now[:danger] = I18n.t 'msg_update_failure'
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @task = Task.find_by(id: params[:id])
    if @task.nil?
      flash[:danger] = I18n.t 'msg_delete_failure'
      redirect_to root_path
    end

    @task.destroy
    flash[:notice] = I18n.t 'msg_delete_success'
    redirect_to root_path
  end

  private

  def task_data(form_params)
    {
      title: form_params[:task][:title],
      description: form_params[:task][:description],
      due_date_at: form_params[:task][:due_date_at],
      status: form_params[:task][:status],
   }
  end

  def get_status_map
    {
      STATUS_NOT_STARTED => I18n.t('status_not_started'),
      STATUS_IN_PROGRESS => I18n.t('status_in_progress'),
      STATUS_COMPLETED => I18n.t('status_completed'),
    }
  end
end
