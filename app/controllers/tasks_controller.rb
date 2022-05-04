class TasksController < ApplicationController
  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)
    if @task.save
      redirect_to tasks_url
    else
      render 'new'
    end
  end

  def show
    @task = Task.find(params[:id])
    @wday = Wday.new
  end

  def index
    @tasks = Task.all
    @wday = Wday.new
  end

  def destroy
    @task = Task.find(params[:id])
    @task.destroy
    redirect_to tasks_url
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
      redirect_to @task
    else
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
