class TodoToLabel < ApplicationRecord
  belongs_to :todo
  belongs_to :label
end
