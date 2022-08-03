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
    category = find_category_with_err_handling(params[:id])
    if category.destroy
      flash[:success] = I18n.t 'task_delete_success'
    else
      category.errors.full_messages.each do |msg|
        flash[:danger] = msg
      end
    end
    redirect_to categories_url
  end

  def edit
    @category = find_category_with_err_handling(params[:id])
  end

  def update
    @category = find_category_with_err_handling(params[:id])
    if @category.update(category_params)
      flash[:success] = I18n.t 'task_update_success'
      redirect_to categories_url
    else
      flash.now[:danger] = I18n.t 'task_update_failed'
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def category_params
    params.require(:category).permit(:name)
  end

  def find_category_with_err_handling(category_id)
    category = Category.find_by(id: category_id)
    if category.blank?
      flash[:danger] = I18n.t 'category_not_exist'
      return redirect_to categories_url
    end
    category
  end
  
end
