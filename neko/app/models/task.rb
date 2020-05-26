class Task < ApplicationRecord
  validates :name, presence: true
  belongs_to :status

  def self.rearrange(column, direction)
    case column
    when 'due_at'
      order(have_a_due: :desc).order("tasks.#{column} #{direction}")
    when 'status_id'
      eager_load(:status).order("statuses.phase #{direction}")
    else
      order("tasks.#{column} #{direction}")
    end
  end

  def self.search(search)
    if search[:name].blank? && search[:status_id].blank?
      eager_load(:status).all
    elsif search[:status_id].blank?
      eager_load(:status).where(['tasks.name LIKE ?', "%#{search[:name]}%"])
    elsif search[:name].blank?
      eager_load(:status).where(status_id: search[:status_id])
    else
      eager_load(:status).where(status_id: search[:status_id]).where(['tasks.name LIKE ?', "%#{search[:name]}%"])
    end
  end
end
