module ApplicationHelper
  def current_user
    current_user ||= User.find_by(id: session[:user_id])
  end

  def get_todos(user)
    @search = params[:search]
    @label = params[:label]
    @status = Todo.status_ids[params[:status]].nil? ? nil : params[:status]
    if Label.find_by(name: @label).nil?
      todos = Todo.includes(:labels).where('title like ? and status_id like ? and user_id = ?', "%#{@search}%", @status.nil? ? '%' : Todo.status_ids[@status], user.id)
    else
      todos = Todo.includes(:labels, :todo_to_labels).where('title like ? and status_id like ? and user_id = ? and labels.name = ?', "%#{@search}%", @status.nil? ? '%' : Todo.status_ids[@status], user.id, @label).references(:labels)
    end
    @direction = %w(asc desc).include?(params[:direction]) ? params[:direction] : 'desc'
    @sort = %w(created_at deadline priority_id).include?(params[:sort]) ? params[:sort] : 'todos.created_at'
    @todos = todos.page(params[:page]).order("#{@sort} #{@direction}")
  end

  def set_labels(action)
    params[:labels].each do |label|
      if !label[1][:name].blank?
        found_label = Label.find_by(name: label[1][:name])
        if found_label.nil?
          @todo.labels.build(name: label[1][:name])
        else
          @todo.labels << found_label if !@todo.labels.include?(found_label)
        end
      end

      if action == 'update' && !label[0].include?('x') && Label.find_by(id: label[0]).name != label[1][:name]
        @todo.todo_to_labels.find_by(label_id: Label.find_by(id: label[0])).destroy
      end
    end
  end
end
