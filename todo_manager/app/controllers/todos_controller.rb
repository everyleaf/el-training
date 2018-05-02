class TodosController < ApplicationController
  def index
    @search = params[:search]
    @status = ['0', '1', '2'].include?(params[:status]) ? params[:status] : '%'
    todos = Todo.where('title like ? and status_id like ?', "%#{@search}%", @status)
    @direction = ['asc', 'desc'].include?(params[:direction]) ? params[:direction] : 'desc'
    @sort = ['created_at', 'deadline', 'priority_id'].include?(params[:sort]) ? params[:sort] : 'created_at'
    @todos = todos.page(params[:page]).per(10).order("#{@sort} #{@direction}")
    render 'index'
  end

  def new
    @todo = Todo.new
    @todo.deadline = Time.current.tomorrow.strftime('%Y-%m-%dT%H:%M')
  end

  def create
    @todo = Todo.new(title: params[:title], content: params[:content], priority_id: params[:todo][:priority_id], deadline: params[:deadline])
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
    @todo.priority_id = params[:todo][:priority_id]
    @todo.status_id = params[:todo][:status_id]
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
