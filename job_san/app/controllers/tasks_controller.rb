class TasksController < ApplicationController
  def index
    @tasks = Task.all
  end

  def show
    id = params[:id]
    @task = Task.find_by(id: id)
  end

  def new
    @task = Task.new
  end

  def 

  def create
    @task = Task.new(create_params)

    # ステップ11までバリデーションは実装しません。
    if @task.save
      redirect_to tasks_path, notice: 'タスクができたよ！'
    else
      flash.now[:alert] = 'タスクができなかったよ！'
      render :new
    end
  end

  private

  def create_params
    params.require(:task).permit(:name, :description)
  end

end
