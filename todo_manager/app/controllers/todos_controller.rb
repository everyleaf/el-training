class TodosController < ApplicationController
  before_action :authenticate_user
  before_action :ensure_correct_user, only: %i(detail edit update destroy)

  def index
    get_todos(current_user)
    render 'index'
  end

  def new
    @todo = Todo.new
    @todo.deadline = Time.current.tomorrow.strftime('%Y-%m-%dT%H:%M')
  end

  def create
    @todo = current_user.todos.new(title: params[:title], content: params[:content], priority_id: params[:todo][:priority_id], deadline: params[:deadline])
    if @todo.save
      flash[:notice] = I18n.t('flash.todos.create')
      redirect_to('/')
    else
      render 'new'
    end
  end

  def detail
    @todo = Todo.find_by(id: params[:id])
  end

  def edit
    @todo = Todo.find_by(id: params[:id])
  end

  def update
    @todo = Todo.find_by(id: params[:id])
    @todo.assign_attributes({
      title: params[:title],
      content: params[:content],
      priority_id: params[:todo][:priority_id],
      status_id: params[:todo][:status_id],
      deadline: params[:deadline]
    })
    if @todo.save
      flash[:notice] = I18n.t('flash.todos.update')
      redirect_to("/todos/#{@todo.id}/detail")
    else
      render 'edit'
    end
  end

  def destroy
    @todo = Todo.find_by(id: params[:id])
    if @todo.destroy
      flash[:notice] = I18n.t('flash.todos.destroy.success')
      redirect_to('/')
    else
      flash.now[:notice] = I18n.t('flash.todos.destroy.failure')
      render 'detail'
    end
  end

  def ensure_correct_user
    @todo = Todo.find_by(id: params[:id])
    if current_user.user_type != 'admin' && current_user.id != @todo.user_id
      flash[:notice] = I18n.t('flash.users.authorization.failure')
      redirect_to('/')
    end
  end
end
