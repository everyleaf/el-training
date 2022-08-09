module SessionsHelper
  # 引数のユーザでログイン
  def log_in(user)
    session[:user_id] = user.id
  end

  # 現在ログイン中のユーザ
  def current_user
    return unless session[:user_id]
    @current_user ||= User.find_by(id: session[:user_id])
  end

end
