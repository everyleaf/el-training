class Task < ApplicationRecord
  validates :name, presence: true
  belongs_to :status

  def self.search(search)
    if search[:name].blank? && search[:status].nil?
      Task.eager_load(:status).all
    elsif search[:status].nil?
      Task.eager_load(:status).where(['tasks.name LIKE ?', "%#{search[:name]}%"])
    elsif search[:name].blank?
      Task.eager_load(:status).where(status_id: search[:status])
    else
      Task.eager_load(:status).where(status_id: search[:status]).where(['tasks.name LIKE ?', "%#{search[:name]}%"])
    end
  end
end
