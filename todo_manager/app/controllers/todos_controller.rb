class TodosController < ApplicationController
  def index
    @search = params[:search]
    @status = params[:status].nil? ? '' : params[:status]
    todos = Todo.where('title like ? and status_id = ?', "%#{@search}%", @status)
    @direction = !params[:direction].nil? ? params[:direction] : 'desc'
    @sort = params[:sort]
    @todos = todos.order("#{Todo.column_names.include?(@sort) ? @sort : 'created_at'} #{@direction}")
    render 'index'
  end

  def new
    @todo = Todo.new
    @todo.deadline = Time.current.tomorrow.strftime('%Y-%m-%dT%H:%M')
  end

  def create
    @todo = Todo.new(title: params[:title], content: params[:content], deadline: params[:deadline])
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
    @todo.deadline = params[:deadline]
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
