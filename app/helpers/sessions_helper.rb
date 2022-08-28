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

  # ユーザがログインしていればtrue
  def logged_in?
    !current_user.nil?
  end

  # ヘルパー内でのインスタンス変数使用を許可
  # rubocop:disable Rails/HelperInstanceVariable
  def log_out
    session.delete(:user_id)
    @current_user = nil
  end
  # rubocop:enable Rails/HelperInstanceVariable
end
