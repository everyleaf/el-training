class InsertInitialStatuses < ActiveRecord::Migration[6.0]
  def change
    statuses = ['未着手', '着手中', '完了']
    statuses.each_with_index do |s, idx|
      Status.create(name: s, phase: idx)
    end
  end
end
