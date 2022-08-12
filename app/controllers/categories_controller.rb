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
      # TODO: レスキューを用いて具体的なエラーメッセージを
      # TODO: フラッシュメッセージで表示(別Issue)
      flash[:danger] = I18n.t 'category_create_failed'
    end
    redirect_to categories_url
  end

  def destroy
    category = find_category_with_err_handling(params[:id])
    if category.destroy
      flash[:success] = I18n.t 'category_delete_success'
    else
      flash[:danger] = I18n.t 'category_delete_failed'
    end
    redirect_to categories_url
  end

  def edit
    @category = find_category_with_err_handling(params[:id])
  end

  def update
    @category = find_category_with_err_handling(params[:id])
    if @category.update(category_params)
      flash[:success] = I18n.t 'category_update_success'
      redirect_to categories_url
    else
      flash[:danger] = I18n.t 'category_update_failed'
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def category_params
    params.require(:category).permit(:name)
  end

  def find_category_with_err_handling(category_id)
    category = Category.find_by(id: category_id)
    if category_exist?(category) && operation_allowed?(category)
      return category
    end

    redirect_to categories_url
  end

  def category_exist?(category)
    if category.blank?
      flash[:danger] = I18n.t 'category_not_exist'
      return false
    end

    true
  end

  def operation_allowed?(category)
    if category.name == '未分類'
      flash[:danger] = I18n.t 'operation_not_allowed'
      return false
    end
    
    true
  end
end
