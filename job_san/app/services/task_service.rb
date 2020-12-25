# frozen_string_literal: true

class TaskService
  def initialize(task)
    @update_task = task
  end

  def update_task(params)
    if @update_task.done? && params[:status].present?
      @update_task.errors.add(:status, '完了したタスクはステータスを更新できません')
      return @update_task
    end

    set_params(params[:task])
    move_task_status(params[:task][:status])
    @update_task.save
    @update_task
  end

  private

  def set_params(params)
    @update_task.name = params[:name] if params[:name]
    @update_task.description = params[:description] if params[:description]
    @update_task.target_date = params[:target_date] if params[:target_date]
  end

  def move_task_status(status)
    case status
    when 'todo' then
      @update_task.turn_back
    when 'doing' then
      @update_task.start
    when 'done' then
      @update_task.finish
    else
      # noop
    end
  end
end
