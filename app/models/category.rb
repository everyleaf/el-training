class Category < ApplicationRecord
  TASK_DEFAULT_BELONG = '未分類'.freeze
  has_many :task, dependent: :restrict_with_error

  # TODO: ユーザモデルが追加されたら、nameのユニーク性のスコープをユーザに変更する
  validates :name, presence: true, uniqueness: true

  def operation_prohibited?
    self.name == Category::TASK_DEFAULT_BELONG
  end

  def operation_allowed?
    !(self.operation_prohibited?)
  end
end
