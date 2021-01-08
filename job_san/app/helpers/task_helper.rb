# frozen_string_literal: true

module TaskHelper
  def viewed_target_date(task)
    return I18n.t('view.task.target_date.blank') unless task&.target_date

    task.target_date.strftime('%Y年%m月%d日')
  end

  def status_option(task)
    task&.status || I18n.t('enums.task.status.todo')
  end
end
