class TaskController < ApplicationController
  def list
    # タスク一覧オブジェクト取得
    # Formのようなオブジェクトを作成すべきか？
    # ただし、Formではないのでこれでよいと判断
    @list_items = Task.joins(:user).select("tasks.title, tasks.label, users.name, tasks.status")
  end
end
