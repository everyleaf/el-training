# frozen_string_literal: true

class Label < ApplicationRecord
  has_many :task_label_relations, dependent: :delete_all
  has_many :tasks, through: :task_label_relations
  validates :name, presence: true, length: { maximum: 50 }, uniqueness: true

  # 中間テーブルの参照先がデフォルトでLabel::TaskLabelRelationとなってしまっている
  # また、class_nameで指定したクラスを見に行かないためここに宣言する。
  class TaskLabelRelation < ApplicationRecord
    self.table_name = 'task_label_relations'

    belongs_to :task
    belongs_to :label
  end
end
