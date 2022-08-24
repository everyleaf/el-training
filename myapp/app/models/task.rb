# frozen_string_literal: true

class Task < ApplicationRecord
  # user対応コメントアウト
  # # 結合キー
  # belongs_to :user

  # ステータスEnum
  enum status: {
    not_started: '1',
    in_progress: '2',
    closed: '3',
  }

  # ステータス変換用Enum
  STATUS_VIEW = {
    Task.statuses[:not_started] => '未着手',
    Task.statuses[:in_progress] => '着手中',
    Task.statuses[:closed] => '完了',
  }.freeze
end