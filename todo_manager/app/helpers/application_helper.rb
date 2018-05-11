module ApplicationHelper
  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end
end
