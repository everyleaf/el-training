class AdminController < ApplicationController
  # TODO: ユーザにロールを追加後、before_actionでcurrent_userがadminユーザか確認

  include TasksHelper
  def index
    # preloadを使用してN+1問題に対応
    @users = User.preload(:categories, :tasks).all
  end

  def show
    # preloadを使用してN+1問題に対応
    @user = User.preload(:categories, :tasks).find(params[:id])
  end
end
