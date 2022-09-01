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

  private

  def label_params
    params.require(:label).permit(:name)
  end
end
