# frozen_string_literal: true

module TaskHelper
  def viewed_target_date(task)
    task&.target_date || I18n.t('view.task.target_date.blank')
  end
end
