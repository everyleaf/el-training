# Taskモデルは、タスクのタイトルと詳細を管理します。
# タイトルは必須であり、空であってはなりません。
class Task < ApplicationRecord
  validates :title, presence: true
end
