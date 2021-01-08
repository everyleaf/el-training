# frozen_string_literal: true

class TaskService
  class TransferStatusError < StandardError; end

  def initialize(task)
    @update_task = task
  end

  # AASM経由でデータの更新を行うため、ステータスとそれ以外のカラムの更新は別で行う。
  def update_task(params)
    Task.transaction do
      transfer_status(params[:status])
      update_task_attributes(params)
    end
    @update_task
  rescue AASM::InvalidTransition
    @update_task.errors.add(:status, I18n.t('task.error.transfer_status'))
    @update_task
  rescue TaskService::TransferStatusError
    @update_task.errors.add(:status, :invalid)
    @update_task
  rescue ActiveRecord::RecordInvalid
    @update_task.save
    @update_task
  end

  private

  def update_task_attributes(params)
    @update_task.assign_attributes(params.except(:status))
    @update_task.save!
  end

  def transfer_status(status)
    return if status.blank?

    case status.to_sym
    when Task::STATE_TODO then
      @update_task.turn_back!
    when Task::STATE_DOING then
      @update_task.start!
    when Task::STATE_DONE then
      @update_task.finish!
    else
      raise TaskService::TransferStatusError
    end
  end
end
