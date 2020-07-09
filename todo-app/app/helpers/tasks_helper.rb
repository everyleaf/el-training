module TasksHelper

  STATUS_STR = %w{未着手 実施中 完了}.freeze

  def to_status_str(st)
    STATUS_STR[st]
  end
end
