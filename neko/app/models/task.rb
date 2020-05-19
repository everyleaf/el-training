class Task < ApplicationRecord
  validates :name, presence: true
  belongs_to :status

  def self.search(search)
    if search[:name].blank? && search[:status].nil?
      Task.includes(:status).all
    elsif search[:status].nil?
      Task.includes(:status).where(['tasks.name LIKE ?', "%#{search[:name]}%"])
    elsif search[:name].blank?
      Task.includes(:status).where(status_id: search[:status])
    else
      Task.includes(:status).where(status_id: search[:status]).where(['name LIKE ?', "%#{search[:name]}%"])
    end
  end
end
