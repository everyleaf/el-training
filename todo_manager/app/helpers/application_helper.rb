module ApplicationHelper
  def current_user
    current_user ||= User.find_by(id: session[:user_id])
  end

  def get_todos(user)
    @search = params[:search]
    @status = Todo.status_ids[params[:status]].nil? ? nil : params[:status]
    todos = Todo.where('title like ? and status_id like ? and user_id = ?', "%#{@search}%", @status.nil? ? '%' : Todo.status_ids[@status], user.id)
    @direction = %w(asc desc).include?(params[:direction]) ? params[:direction] : 'desc'
    @sort = %w(created_at deadline priority_id).include?(params[:sort]) ? params[:sort] : 'created_at'
    @todos = todos.page(params[:page]).order("#{@sort} #{@direction}")
  end
end
