class Task < ApplicationRecord
  validates :name, presence: true
  belongs_to :status

  def self.search(search)
    if search[:name].blank? && search[:status_id].blank?
      Task.eager_load(:status).all
    elsif search[:status_id].blank?
      Task.eager_load(:status).where(['tasks.name LIKE ?', "%#{search[:name]}%"])
    elsif search[:name].blank?
      Task.eager_load(:status).where(status_id: search[:status_id])
    else
      Task.eager_load(:status).where(status_id: search[:status_id]).where(['tasks.name LIKE ?', "%#{search[:name]}%"])
    end
  end
end
