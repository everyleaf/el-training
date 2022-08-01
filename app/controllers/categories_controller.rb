class CategoriesController < ApplicationController
  def index
    @categories = Category.all
    @category   = Category.new
  end

  def create
    @category = Category.new(category_params)
    #TODO バグ:同じ名前でカテゴリを作成するとsave分岐に入ってエラーが出る
    if @category.save
      flash[:success] = I18n.t 'category_create_success'
      redirect_to categories_url
    else
      flash.now[:danger] = I18n.t 'category_create_failed'
      render :index, status: :unprocessable_entity
    end
  end

  private

  def category_params
    params.require(:category).permit(:name)
  end
end
