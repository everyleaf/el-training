class TasksController < ApplicationController
  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)
    if @task.save
      flash[:success] = I18n.t 'task_create_success'
      redirect_to tasks_url
    else
      flash.now[:danger] = I18n.t 'task_create_failed'
      render 'new'
    end
  end

  def show
    @task = Task.find_by(id: params[:id])
    return redirect_to_index_with_msg if @task.blank?
  end

  def index
    @tasks = Task.all
  end

  def destroy
    @task = Task.find_by(id: params[:id])
    return redirect_to_index_with_msg if @task.blank?

    if @task.destroy
      flash[:success] = I18n.t 'task_delete_success'
      return redirect_to tasks_url
    else
      flash[:danger] = I18n.t 'task_delete_failed'
      return redirect_to task
    end

  end

  def edit
    @task = Task.find(params[:id])
  end

  def update
    @task = Task.find(params[:id])
    if @task.update(task_params)
      flash[:success] = I18n.t 'task_update_success'
      redirect_to @task
    else
      flash.now[:danger] = I18n.t 'task_update_failed'
      render 'edit'
    end
  end

  private

  def task_params
    params.require(:task).permit(:name,       :description,
                                 :start_date, :necessary_days,
                                 :progress,   :priority)
  end

  def redirect_to_index_with_msg
    flash[:danger] = I18n.t 'task_not_exist'
    return redirect_to tasks_url
  end
end
