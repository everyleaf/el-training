class Category < ApplicationRecord
  DEFAULT_CREATED_CATEGORY = '未分類'.freeze

  belongs_to :user
  has_many :task, dependent: :restrict_with_error
  validates :name, presence: true, uniqueness: { scope: :user }

  def operation_prohibited?
    self.name == Category::DEFAULT_CREATED_CATEGORY
  end
end
