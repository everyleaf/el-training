# TaskController is a controller to handle basic CRUD operations for "task"
class TasksController < ApplicationController
  MSG_CREATE_SUCCESS = 'Created a task successfully.'
  MSG_CREATE_FAILURE = 'Failed to create a task.'
  MSG_UPDATE_SUCCESS = 'Updated a task successfully.'
  MSG_UPDATE_FAILURE = 'Failed to update a task.'
  MSG_DELETE_SUCCESS = 'Deleted a task successfully.'
  MSG_DELETE_FAILURE = 'Failed to delete a task.' # not in used

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
      flash[:notice] =  MSG_CREATE_SUCCESS
    else
      flash[:notice] = MSG_CREATE_FAILURE
    end

    redirect_to root_path
  end

  def show
    @task = Task.find_by(id: params[:id])
    redirect_to root_path if @task.nil?
  end

  def edit
    @task = Task.find_by(id: params[:id])
    redirect_to root_path if @task.nil?
  end

  def update
    @task = Task.find_by(id: params[:id])
    redirect_to root_path if @task.nil?

    data = {title: params[:task][:title], description: params[:task][:description]}
    if @task.update(data)
      flash[:notice] = MSG_UPDATE_SUCCESS
    else
      flash[:notice] = MSG_UPDATE_FAILURE
    end

    redirect_to root_path
  end

  def destroy
    @task = Task.find_by(id: params[:id])
    redirect_to root_path if @task.nil?

    @task.destroy
    flash[:notice] = MSG_DELETE_SUCCESS
    redirect_to root_path
  end
end
