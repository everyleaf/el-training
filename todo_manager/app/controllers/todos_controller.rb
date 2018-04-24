class TodosController < ApplicationController
  def index
    @todos = Todo.all.order(created_at: :desc)
  end

  def new
    @todo = Todo.new
  end

  def create
    @todo = Todo.new(title: params[:title], content: params[:content])
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
    @todo.title = params[:title]
    @todo.content = params[:content]
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
      flash[:notice] = I18n.t('flash.todos.destroy.failure')
      render 'detail'
    end
  end
end
