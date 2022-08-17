class AdminController < ApplicationController
  include TasksHelper
  def index
    @users = User.preload(:categories, :tasks).all # preloadを使用してN+1問題に対応
  end

  def show
    @user = User.find(params[:id])
  end
end
