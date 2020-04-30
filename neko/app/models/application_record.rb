class ApplicationRecord < ActiveRecord::Base
  validates :name, presence: true
  self.abstract_class = true
end
