# frozen_string_literal: true

class Task < ApplicationRecord
  include AASM

  validates :name, presence: true, length: { maximum: 255 }
  validates :description, length: { maximum: 255 }
  enum priority: %i[low medium high]
  # TODO: Task.statuses_I18nを使いたいが、aasmとの相性が悪いらしく導入できない。
  STATUSES = %i[todo doing done].each_with_object({}) { |key, ini| ini[key] = I18n.t("enums.task.status.#{key}") }

  aasm(column: :status) do
    state :todo,  display: I18n.t('enums.task.status.todo'), initial: true
    state :doing, display: I18n.t('enums.task.status.doing')
    state :done,  display: I18n.t('enums.task.status.done')

    event :turn_back do
      transitions from: :doing, to: :todo
    end

    event :start do
      transitions from: :todo, to: :doing
    end

    event :finish do
      transitions from: %i[todo doing], to: :done
    end
  end
end
