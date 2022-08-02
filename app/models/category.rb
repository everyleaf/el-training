class Category < ApplicationRecord
  has_many :task, dependent: :restrict_with_exception

  # TODO: ユーザモデルが追加されたら、nameのユニーク性のスコープをユーザに変更する
  validates :name, presence: true, uniqueness: true

end
