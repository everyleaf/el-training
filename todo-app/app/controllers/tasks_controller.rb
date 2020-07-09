class TasksController < ApplicationController
  def index

    @tasks = Task.all.page(params[:page]).per(10)
  end

  def show
    redirect_to action: "index"
  end

  def update
    @task = Task.find(params[:id])
    @task.assign_attributes(task_params)

    if @task.save
      flash.notice = as_success_message(@task.name, "action-update")
      redirect_to action: "index"
    else
      flash.alert = error_message
      render action: "edit"
    end

  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)
    if @task.save
      flash.notice  = as_success_message(@task.name, "action-create")

      redirect_to action: "index"
    else
      flash.alert = error_message
      render action: "new"
    end

  end

  def destroy
    task = Task.find(params[:id])
    task.destroy!
    flash.notice = as_success_message(@task.name, "action-delete")

    redirect_to action: "index"

  end

  def edit
    @task = Task.find(params[:id])
  end


  private

  def task_params
    params.require(:task).permit(:name, :due_date)
  end

  def as_success_message(name, action_key)
    t('msg-success', name: name, action: t(action_key))
  end

  def error_message
    t('msg-error')
  end
end
