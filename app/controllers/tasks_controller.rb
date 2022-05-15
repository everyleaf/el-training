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
    @task = find_task_with_err_handling(params[:id])
  end

  def index
    @tasks = Task.all
  end

  def destroy
    @task = find_task_with_err_handling(params[:id])

    if @task.destroy
      flash[:success] = I18n.t 'task_delete_success'
      redirect_to tasks_url
    else
      flash[:danger] = I18n.t 'task_delete_failed'
      redirect_to @task
    end
  end
  
  def edit
    @task = find_task_with_err_handling(params[:id])
  end

  def update
    @task = find_task_with_err_handling(params[:id])
    if @task.update(task_params)
      flash[:success] = I18n.t 'task_update_success'
      redirect_to @task
    else
      flash.now[:danger] = I18n.t 'task_update_failed'
      render 'edit'
    end
  end
  end

  private

  def task_params
    params.require(:task).permit(:name,       :description,
                                 :start_date, :necessary_days,
                                 :progress,   :priority)
  end

  def find_task_with_err_handling(task_id)
    task = Task.find_by(id: task_id)
    if task.blank?
      flash[:danger] = I18n.t 'task_not_exist'
      return redirect_to tasks_url
    end
    task
  end

end
