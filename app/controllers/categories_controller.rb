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

  private

  def category_params
    params.require(:category).permit(:name)
  end
end
