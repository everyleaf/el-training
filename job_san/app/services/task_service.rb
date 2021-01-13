# frozen_string_literal: true

class TaskService
  class TransferStatusError < StandardError; end

  def initialize(task)
    @task = task
  end

  def create_task(params)
    Task.transaction do
      @task.save!
      labels = params[:attach_labels]
      attach_labels(labels) if labels.present?
    end
    @task
  rescue ActiveRecord::RecordInvalid
    @task
  end

  # AASM経由でデータの更新を行うため、ステータスとそれ以外のカラムの更新は別で行う。
  def update_task(params)
    Task.transaction do
      transfer_status(params[:status])
      update_task_attributes(params)
    end
    @task
  rescue AASM::InvalidTransition
    @task.errors.add(:status, I18n.t('task.error.transfer_status'))
    @task
  rescue TaskService::TransferStatusError
    @task.errors.add(:status, :invalid)
    @task
  rescue ActiveRecord::RecordInvalid
    @task
  end

  private

  def attach_labels(label_ids)
    relations = Label.where(id: label_ids.map(&:to_i)).map do |l|
      Task::TaskLabelRelation.new(label: l, task: @task)
    end
    Task::TaskLabelRelation.import relations
  end

  def update_task_attributes(params)
    update_labels(params[:attach_labels]) if params[:attach_labels].present?
    @task.assign_attributes(params.except(:status, :attach_labels))
    @task.save!
  end

  def update_labels(label_ids)
    @task.labels.delete_all
    attach_labels(label_ids)
  end

  def transfer_status(status)
    return if status.blank?

    case status.to_sym
    when Task::STATE_TODO then
      @task.turn_back!
    when Task::STATE_DOING then
      @task.start!
    when Task::STATE_DONE then
      @task.finish!
    else
      raise TaskService::TransferStatusError
    end
  end
end
