class TasksController < ApplicationController
  before_action :set_task, only: %i[show edit update destroy]

  # GET /tasks or /tasks.json
  def index
    query = Task.all
    query = query.sort_by_keyword(search_params[:sort])
    query = query.search_by_status(search_params[:status]) if search_params[:status].present?
    query = query.search_by_keyword(search_params[:keyword]) if search_params[:keyword].present?
    query = query.page(search_params[:page])

    @tasks = query
  end

  # GET /tasks/1 or /tasks/1.json
  def show; end

  # GET /tasks/new
  def new
    @task = Task.new
  end

  # GET /tasks/1/edit
  def edit; end

  # POST /tasks or /tasks.json
  def create
    @task = Task.new(task_params)
    @task.user_id = 1 # TODO: ログイン機能実装後に修正する

    respond_to do |format|
      if @task.save
        format.html do
          redirect_to task_url(@task), flash: { success: I18n.t('messages.create', model_name: I18n.t('activerecord.models.task')) }
        end
        format.json { render :show, status: :created, location: @task }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tasks/1 or /tasks/1.json
  def update
    respond_to do |format|
      if @task.update(task_params)
        format.html do
          redirect_to task_url(@task), flash: { success: I18n.t('messages.update', model_name: I18n.t('activerecord.models.task')) }
        end
        format.json { render :show, status: :ok, location: @task }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tasks/1 or /tasks/1.json
  def destroy
    @task.destroy

    respond_to do |format|
      format.html do
        redirect_to tasks_url, flash: { success: I18n.t('messages.delete', model_name: I18n.t('activerecord.models.task')) }
      end
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_task
    @task = Task.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def task_params
    params.require(:task).permit(:title, :description, :status, :priority, :expires_at, :user_id)
  end

  def search_params
    params[:sort] = Task.sort_params_checker(params[:sort])
    params.permit(:page, :keyword, :status, :sort)
  end
end
