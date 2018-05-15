class AdminController < ApplicationController
  before_action :authenticate_user, :authorize_user

  def index
    @users = User.all.page(params[:page])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(name: params[:name], password: params[:password], user_type: params[:user][:user_type])
    if @user.save
      flash[:notice] = I18n.t('flash.users.create')
      redirect_to('/admin')
    else
      render 'new'
    end
  end

  def show
    @user = User.find_by(id: params[:id])
  end

  def edit
    @user = User.find_by(id: params[:id])
  end

  def update
    @user = User.find_by(id: params[:id])
    @user.name = params[:name]
    if @user.user_type == 'admin' && User.where(user_type: 'admin').count <= 1
      @user.user_type = 'admin'
    else
      @user.user_type = params[:user][:user_type]
    end
    if !params[:password].nil?
      @user.password = params[:password]
    end

    if @user.save
      flash[:notice] = I18n.t('flash.users.update')
      redirect_to("/admin/#{@user.id}/edit")
    else
      render 'edit'
    end
  end

  def destroy
    @user = User.find_by(id: params[:id])

    if @user.id != current_user.id && @user.destroy
      flash[:notice] = I18n.t('flash.users.destroy.success')
      redirect_to('/admin')
    else
      flash.now[:notice] = I18n.t('flash.users.destroy.failure')
      render 'show'
    end
  end

  def todos
    @user = User.find_by(id: params[:id])
    get_todos(@user)
    render 'todos'
  end

  def new_todos
    @user = User.find_by(id: params[:id])
    @todo = Todo.new
    @todo.deadline = Time.current.tomorrow.strftime('%Y-%m-%dT%H:%M')
  end

  def create_todos
    @user = User.find_by(id: params[:id])
    @todo = @user.todos.new(title: params[:title], content: params[:content], priority_id: params[:todo][:priority_id], deadline: params[:deadline])
    if @todo.save
      flash[:notice] = I18n.t('flash.todos.create')
      redirect_to("/admin/#{params[:id]}/todos")
    else
      render 'new_todos'
    end
  end

  def authorize_user
    if current_user.user_type != 'admin'
      flash[:notice] = I18n.t('flash.users.authorization.failure')
      redirect_to('/')
    end
  end

end
