class User < ApplicationRecord
  has_many :task_category, dependent: :destroy
end
