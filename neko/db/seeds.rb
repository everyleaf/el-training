statuses = %w[未着手 着手中 完了]
statuses.each_with_index do |status, idx|
  Status.create(name: status, phase: idx)
end
