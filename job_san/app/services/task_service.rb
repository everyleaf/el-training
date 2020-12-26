# frozen_string_literal: true

class TaskService
  class TransferStatusError < StandardError; end

  def initialize(task)
    @update_task = task
  end

  def update_task(params)
    transfer_status(params[:task][:status])
    @update_task.assign_attributes(params[:task].except(:status))
    @update_task.save
    @update_task
  end

  private

  def transfer_status(status)
    return if status.blank?

    case status.to_sym
    when Task::STATE_TODO then
      @update_task.turn_back
    when Task::STATE_DOING then
      @update_task.start
    when Task::STATE_DONE then
      @update_task.finish
    else
      raise TaskService::TransferStatusError, "Unexpected. param: #{status}"
    end
  end
end
