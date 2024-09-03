require 'date'

class DateTimeValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    if attribute.to_s.eql?("due_date_at_before_type_cast") && !value.to_s.empty?
      begin
        DateTime.parse(value.to_s)
      rescue
        record.errors.add "due_date_at", (options[:message] || "is not a valid datetime")
      end
    end
  end
end

class Task < ApplicationRecord
  validates :title, presence: true, length: { maximum: 50 }
  validates :description, length: { maximum: 500 }
  validates :due_date_at_before_type_cast, date_time: true
end
