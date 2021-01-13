# frozen_string_literal: true

module Admin
  class LabelsController < ApplicationController
    before_action :logged_in_user, :authorized_user

    def index
      @query = Label.ransack(params[:query])
      @labels = @query.result.order(created_at: :desc).page params[:page]
    end

    def new
      @label = Label.new
    end

    def create
      @label = Label.new(label_params)
      if @label.save
        redirect_to admin_labels_path, notice: I18n.t('view.label.flash.created')
      else
        @errors = @label.errors
        flash.now[:alert] = I18n.t('view.label.flash.not_created')
        render new_admin_label_path
      end
    end

    def edit
      @label = Label.find_by(id: params[:id])
      redirect_to admin_labels_path, notice: I18n.t('view.label.error.not_found') unless @label
    end

    def update
      @label = Label.find_by(id: params[:id])
      redirect_to admin_labels_path, notice: I18n.t('view.label.error.not_found') unless @label

      @label.update(label_params)
      @errors = @label.errors
      if @errors.blank?
        flash[:notice] = I18n.t('view.label.flash.updated')
        redirect_to admin_labels_path
      else
        flash.now[:alert] = I18n.t('view.label.flash.not_updated')
        render :edit
      end
    end

    def destroy
      label = Label.find_by(id: params[:id])
      return redirect_to admin_labels_path, notice: I18n.t('view.label.error.not_found') unless label

      if label.destroy
        redirect_to admin_labels_path, notice: I18n.t('view.label.flash.deleted')
      else
        @errors = label.errors
        flash.now[:alert] = I18n.t('view.label.flash.not_deleted')
        render admin_labels_path
      end
    end

    private

    def label_params
      params.require(:label).permit(:name)
    end
  end
end
