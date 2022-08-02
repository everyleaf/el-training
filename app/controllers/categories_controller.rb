class CategoriesController < ApplicationController
  def index
    @categories = Category.all
    @category   = Category.new
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      flash[:success] = I18n.t 'category_create_success'
    else
      @category.errors.full_messages.each do |msg|
        flash[:danger] = msg
      end
    end
    redirect_to categories_url
  end

  def destroy
    @category = Category.find(params[:id])
    #TODO タスクを子に持つカテゴリを削除するとエラーが出る
    if @category.destroy
      flash[:success] = I18n.t 'task_delete_success'
    else
      flash[:danger] = I18n.t 'task_delete_failed'
      render turbo_stream: turbo_stream.update('flash', partial: 'shared/flash')
    end
    redirect_to categories_url
  end

  private

  def category_params
    params.require(:category).permit(:name)
  end
end
