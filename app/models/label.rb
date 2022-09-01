class Label < ApplicationRecord
  has_many   :label_tables, dependent: :destroy
  has_many   :tasks, through: :label_tables
  belongs_to :user
end
