class Task < ApplicationRecord
  enum priority: { low:0, middle:1, high:2 }
  enum status: { waiting:0, working:1, completed:2 }
end
