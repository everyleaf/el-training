require 'date'

class DateTimeValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    if attribute.to_s.eql?('due_date_at_before_type_cast') && !value.to_s.empty?
      begin
        DateTime.parse(value.to_s)
      rescue
        record.errors.add 'due_date_at', (options[:message] || :invalid)
      end
    end
  end
end

class Task < ApplicationRecord
  enum :status, { status_not_started: 0, status_in_progress: 1, status_completed: 2 }, validate: true

  validates :title, presence: true, length: { maximum: 50 }
  validates :description, length: { maximum: 500 }
  validates :due_date_at_before_type_cast, date_time: true
  validates :status, inclusion: {
    in: Task.statuses.keys,
    message: :invalid
  }

end
