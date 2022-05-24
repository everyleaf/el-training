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
    @task = Task.find(params[:id])
  end

  def index
    @tasks = Task.all
  end

  def destroy
    @task = Task.find(params[:id])
    @task.destroy
    redirect_to tasks_url
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
end
