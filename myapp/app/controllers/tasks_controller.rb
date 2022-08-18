# frozen_string_literal: true

class TasksController < ApplicationController
  # タスク一覧画面
  def index
    # タスク一覧オブジェクト取得
    # Formのようなオブジェクトを作成すべきか？
    # ただし、Formではないのでこれでよいと判断
    @tasks = Task.joins(:user).all
  end

  # タスク作成画面
  def new
    @task = Task.new

    # 担当者名リスト取得
    @select_user_names = []
    users = User.all
    users.each do |user|
      @select_user_names.push([user.name, user.id])
    end
  end

  # タスク作成画面
  def create
    @task = Task.new(task_params)
    @task.update(task_params[:task]) if task_params[:task].present?

    respond_to do |format|
      if @task.save
        format.html { redirect_to('/', notice: 'タスク作成成功') }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  # タスク詳細画面
  def show
    @task = Task.joins(:user).all.where(id: params[:id]).first
  end

  # タスク編集画面
  def edit
    @task = Task.find(params[:id])

    # 担当者名リスト取得
    @select_user_names = []
    users = User.all
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
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  # タスク削除
  def destroy
    @task = Task.find(params[:id])

    respond_to do |format|
      format.html { redirect_to('/', notice: 'タスク削除成功') } if @task.destroy
    end
  end

  private

  # Taskパラメータ
  def task_params
    task_params =
      params
      .require(:task)
      .permit(
        :title,
        :content,
        :label,
        :user_id,
        :status,
      )
    task_params[:user_id] = task_params[:user_id].to_i

    task_params
  end
end
