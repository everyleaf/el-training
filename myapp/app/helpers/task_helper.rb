# frozen_string_literal: true

module TaskHelper
  # コード→表示文言変換
  def get_status_view(code)
    # 該当するコードを検索し、表示文言返却
    Task::STATUS_VIEW.each_key do |key|
      return Task::STATUS_VIEW[key] if Task.statuses[code] == key
    end

    ''
  end
end
