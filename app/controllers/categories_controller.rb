class CategoriesController < ApplicationController
  before_action :logged_in_user

  def index
    @categories = Category.all
    @category   = @current_user.categories.build
  end

  def create
    @category = @current_user.categories.build(category_params)
    if @category.save
      flash[:success] = I18n.t 'category_create_success'
      redirect_to categories_url
    else
      flash.now[:danger] = I18n.t 'category_create_failed'
      @categories = Category.all
      render :index, status: :unprocessable_entity
    end
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
    params.require(:category).permit(:name,
                                     :current_user)
  end

  def find_category_with_err_handling(category_id)
    category = Category.find_by(id: category_id)
    if category.nil?
      flash[:danger] = I18n.t 'category_not_exist'
      return redirect_to categories_url

    elsif category.operation_prohibited?
      flash[:danger] = I18n.t 'operation_not_allowed'
      return redirect_to categories_url
    end

    category
  end

  def confirm_current_user
    return unless @current_user.nil?

    # TODO: ログインユーザに置き換える
    @current_user = User.find_by(email: 'user_0@example.com') # seedで作成されるユーザ
  end

  def operation_allowed?(category)
    category.name != '未分類'
  end
end
