class TasksController < ApplicationController
  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params) # TODO: strong parameter
    if @task.save
      redirect_to @task
    else
      render 'new'
    end
  end

  def show
    @task = Task.find(params[:id])
  end

  def index
    @tasks = Task.all
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
