class LabelsController < ApplicationController
  before_action :logged_in_user

  def index
    @labels = current_user.labels
    @label  = Label.new
  end

  def create
    @label = current_user.labels.build(label_params)
    if @label.save
      flash[:success] = I18n.t 'label_create_success'
      redirect_to labels_url
    else
      flash.now[:danger] = I18n.t 'label_create_failed'
      @labels = Label.all
      render :index, status: :unprocessable_entity
    end
  end

  def destroy
    label = find_label_with_err_handling(params[:id])
    if label.destroy
      flash[:success] = I18n.t 'label_delete_success'
    else
      flash[:danger] = I18n.t 'label_delete_failed'
    end
    redirect_to labels_url
  end

  private

  def label_params
    params.require(:label).permit(:name)
  end

  def find_label_with_err_handling(label_id)
    label = Label.find_by(id: label_id)
    if label.nil?
      flash[:danger] = I18n.t 'label_not_exist'
      return redirect_to labels_url
    end

    label
  end
end
