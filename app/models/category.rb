class Category < ApplicationRecord
  TASK_DEFAULT_BELONG_NAME = '未分類'.freeze

  belongs_to :user
  has_many :task, dependent: :restrict_with_error
  validates :name, presence: true, uniqueness: { scope: :user }

  # TODO: ユーザモデルが追加されたら、nameのユニーク性のスコープをユーザに変更する

  def operation_prohibited?
    self.name == Category::TASK_DEFAULT_BELONG_NAME
  end
end
