# frozen_string_literal: true

module Api
  class TasksController < Api::ApiController
    before_action :logged_in_user

    def search
      query = current_user.tasks.ransack(search_params)
      tasks = query.result.order(created_at: :desc).page params[:page]
      render json: tasks
    end

    def create
      task = current_user.tasks.new(task_params)
      if task.save
        render json: { message: I18n.t('view.task.flash.created') }
      else
        render json: { message: task.errors }, status: :bad_request
      end
    end

    def update
      task = current_user.tasks.find_by(id: params[:id])
      return render json: { message: I18n.t('view.task.error.not_found') }, status: :not_found unless task

      task = TaskService.new(task).update_task(task_params)
      if task.errors.blank?
        render json: { message: I18n.t('view.task.flash.updated') }
      else
        render json: { message: task.errors }, status: :bad_request
      end
    end

    def destroy
      task = current_user.tasks.find_by(id: params[:id])
      return render json: { message: I18n.t('view.task.error.not_found') }, status: :not_found unless task

      if task.destroy
        render json: { message: I18n.t('view.task.flash.deleted') }
      else
        render json: { message: task.errors }, status: :bad_request
      end
    end

    private

    def task_params
      params.require(:task).permit(:name, :description, :target_date, :status, :priority)
    end

    def search_params
      JSON.parse(params[:query])
    end
  end
end
