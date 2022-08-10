class TasksController < ApplicationController

  # タスク一覧画面
  def list
    # タスク一覧オブジェクト取得
    # Formのようなオブジェクトを作成すべきか？
    # ただし、Formではないのでこれでよいと判断
    @list_items =
      Task
        .joins(:user)
        .select(
          'tasks.title,
          tasks.label,
          users.id as user_id,
          users.name,
          tasks.status'
        )
  end

  # タスク作成画面
  def new
    @task = Task.new

    # 担当者名リスト取得
    @select_user_names = []
    users = User.all.select('users.id, users.name')
    users.each do |user|
      @select_user_names.push([user.name, user.id])
    end
  end

  # タスク作成画面
  def create
    @task = Task.new(task_params)
    @task.update_attributes(task_params[:task]) unless task_params[:task].blank?

    respond_to do |format|
      if @task.save
        format.html { redirect_to('/', notice: 'タスク作成成功') }
        format.json { render :show, status: :created, location: @task }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  # タスク詳細画面
  def show
    @item =
      Task
        .joins(:user)
        .select(
          'tasks.id,
          tasks.title,
          tasks.content,
          tasks.label,
          tasks.user_id,
          users.name, 
          tasks.status'
        )
        .where(id: params[:id])
        .first
  end

  # タスク編集画面
  def edit
    @task = Task.find(params[:id])

    # 担当者名リスト取得
    @select_user_names = []
    users = User.all.select('users.id, users.name')
    users.each do |user|
      @select_user_names.push([user.name, user.id])
    end

    # 状況リスト取得
    @statuses = []
    Task::STATUS_VIEW.each do |key, value|
      @statuses.push([value, key])
    end
  end

  # タスク更新
  def update
    @task = Task.find(params[:id])
    respond_to do |format|
      if @task.update(task_params)
        format.html { redirect_to('/', notice: 'タスク更新成功') }
        format.json { render :show, status: :created, location: @task }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  # Taskパラメータ
  def task_params
    task =
      params
        .require(:task)
        .permit(
          :title,
          :content,
          :label,
          :user_id,
          :status
        )
    task[:user_id] = task[:user_id].to_i

    return task
  end

end
