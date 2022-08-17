class AdminController < ApplicationController
  def index
    @users = User.preload(:categories, :tasks).all # preloadを使用してN+1問題に対応
  end

  def show
  end
end
