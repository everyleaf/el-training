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
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @task = find_task_with_err_handling(params[:id])
  end

  def index
    @tasks = filter_tasks_from_checkbox_params

    # タスクのソート(デフォルトはidの昇順)
    sort_by   = params[:sort].presence      || 'id'
    direction = params[:direction].presence || 'ASC'
    @tasks    = @tasks.order("#{sort_by} #{direction}")
  end

  def destroy
    @task = find_task_with_err_handling(params[:id])

    if @task.destroy
      flash[:success] = I18n.t 'task_delete_success'
      redirect_to tasks_url
    else
      flash[:danger] = I18n.t 'task_delete_failed'
      render turbo_stream: turbo_stream.update('flash', partial: 'shared/flash')
      redirect_to @task
    end
  end

  def edit
    @task = find_task_with_err_handling(params[:id])
  end

  def update
    @task = find_task_with_err_handling(params[:id])
    if @task.update(task_params)
      flash[:success] = I18n.t 'task_update_success'
      redirect_to @task
    else
      flash.now[:danger] = I18n.t 'task_update_failed'
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def task_params
    params.require(:task).permit(
      :name,
      :description,
      :start_date,
      :necessary_days,
      :progress,
      :priority
    )
  end

  def find_task_with_err_handling(task_id)
    task = Task.find_by(id: task_id)
    if task.blank?
      flash[:danger] = I18n.t 'task_not_exist'
      return redirect_to tasks_url
    end
    task
  end

  def filter_tasks_from_checkbox_params
    if filter_params_all_blank?
      # 検索項目が空のとき、全ての項目にチェックを入れる
      @filter_pri = Task.priorities
      @filter_prg = Task.progresses
      Task.all
    else
      @filter_pri = params.dig(:filter, :priority) # 見つからなければnil
      @filter_prg = params.dig(:filter, :progress) # 見つからなければnil
      Task.where(priority: @filter_pri, progress: @filter_prg)
    end
  end

  def filter_params_all_blank?
    params.dig(:filter, :priority).nil? && params.dig(:filter, :progress).nil?
  end
end
