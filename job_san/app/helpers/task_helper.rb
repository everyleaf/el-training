# frozen_string_literal: true

module TaskHelper
  def viewed_target_date(task)
    return I18n.t('view.task.value_blank') unless task&.target_date

    task.target_date.strftime('%Y年%m月%d日')
  end

  def viewed_labels(task)
    labels = task&.labels || []
    return I18n.t('view.task.value_blank') if labels.blank?

    labels.map(&:name).join(', ')
  end

  def status_option(task)
    task&.status || I18n.t('enums.task.status.todo')
  end

  def attached_label?(task, label_id)
    return unless task

    task.labels.map(&:id).include?(label_id.to_i)
  end
end
