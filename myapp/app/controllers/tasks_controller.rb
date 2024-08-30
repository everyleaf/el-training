# TaskController is a controller to handle basic CRUD operations for "task"
class TasksController < ApplicationController
  def index
    @new_task = Task.new
    @tasks = Task.order('created_at DESC')
  end

  def show
    @task = Task.find_by(id: params[:id])
    redirect_to error_path(404) if @task.nil?
  end

  def create
    data = { title: params[:task][:title], description: params[:task][:description] }
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
  end

  def update
    @task = Task.find_by(id: params[:id])
    redirect_to error_path(404) if @task.nil?

    data = { title: params[:task][:title], description: params[:task][:description] }
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
end
