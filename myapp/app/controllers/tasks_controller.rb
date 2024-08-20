# TaskController is a controller to handle basic CRUD operations for "task"
class TasksController < ApplicationController
  def index
    @new_task = Task.new
    @tasks = Task.all
  end

  def create
    logger.debug { "params => #{params}" }
    data = { title: params[:task][:title], description: params[:task][:description]
}
    @task = Task.new(data)
    if @task.save
      flash[:notice] = 'Created a task successfully'
    else
      flash[:notice] = 'Failed to create a task'
    end

    redirect_to root_path
  end

  def show
    @task = Task.find(params[:id])
    render :show
  end

  def edit
    @task = Task.find(params[:id])
    # render :edit
  end

  def update
    @task = Task.find(params[:id])
    data = {title: params[:task][:title], description: params[:task][:description]}
    if @task.update(data)
      flash[:notice] = 'Updated a task successfully'
    else
      flash[:notice] = 'Failed to update a task'
    end

    redirect_to root_path
  end

  def destroy
    @task = Task.find(params[:id])
    @task.destroy
    flash[:notice] = 'Deleted a task successfully'
    redirect_to root_path
  end
end
