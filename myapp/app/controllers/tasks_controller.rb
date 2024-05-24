class TasksController < ApplicationController
  before_action :set_task, only: %i[ show edit update destroy ]

  # GET /tasks or /tasks.json
  def index
    @tasks = Task.all
  end

  # GET /tasks/1 or /tasks/1.json
  def show
  end

  # GET /tasks/new
  def new
    @task = Task.new
  end

  # GET /tasks/1/edit
  def edit
  end

  # POST /tasks or /tasks.json
  def create
    @task = Task.new(task_params)

    if @task.save
      flash[:notice] = "タスク登録に成功しました。"
      redirect_to task_url(@task)
    else
      flash.now[:alert] = 'タスク登録に失敗しました' # 追加
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /tasks/1 or /tasks/1.json
  def update
    if @task.update(task_params)
      flash[:notice] = "タスク更新に成功しました。"
      redirect_to task_url(@task)
    else
      flash.now[:alert] = "タスク更新に失敗しました。"
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /tasks/1 or /tasks/1.json
  def destroy
    if @task.destroy
      flash[:notice] = "タスク削除に成功しました。"
      redirect_to tasks_url
    else
      flash.now[:alert] = "タスク削除に失敗しました。"
      render :index, status: :unprocessable_entity
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_task
      @task = Task.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def task_params
      params.require(:task).permit(
        :title,
        :details
      )
    end
end
