class Task < ApplicationRecord
  validates :name, presence: true

  enum status: { not_proceed: 0, in_progress: 1, done: 2 }

  def self.rearrange(column, direction)
    if column == 'due_at'
      order(have_a_due: :desc).order("#{column} #{direction}")
    else
      order("#{column} #{direction}")
    end
  end

  def self.search(search)
    if search[:name].blank? && search[:status].blank?
      all
    elsif search[:status].blank?
      where(['name LIKE ?', "%#{search[:name]}%"])
    elsif search[:name].blank?
      where(status: search[:status])
    else
      where(status: search[:status]).where(['name LIKE ?', "%#{search[:name]}%"])
    end
  end
end
