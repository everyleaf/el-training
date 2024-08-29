# TaskController is a controller to handle basic CRUD operations for "task"
class TasksController < ApplicationController
  MSG_CREATE_SUCCESS = I18n.t 'msg_create_success'
  MSG_CREATE_FAILURE = I18n.t 'msg_create_failure'
  MSG_UPDATE_SUCCESS = I18n.t 'msg_update_success'
  MSG_UPDATE_FAILURE = I18n.t 'msg_update_failure'
  MSG_DELETE_SUCCESS = I18n.t 'msg_delete_success'
  MSG_DELETE_FAILURE = I18n.t 'msg_delete_failure'

  def index
    @new_task = Task.new
    @tasks = Task.all
  end

  def show
    @task = Task.find_by(id: params[:id])
    redirect_to error_path(404) if @task.nil?
  end

  def create
    logger.debug { "params => #{params}" }
    data = { title: params[:task][:title], description: params[:task][:description]
}
    @task = Task.new(data)
    if @task.save
      flash[:notice] = MSG_CREATE_SUCCESS
    else
      flash[:notice] = MSG_CREATE_FAILURE
    end

    redirect_to root_path
  end

  def edit
    @task = Task.find_by(id: params[:id])
    redirect_to error_path(404) if @task.nil?
  end

  def update
    @task = Task.find_by(id: params[:id])
    redirect_to error_path(404) if @task.nil?

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
