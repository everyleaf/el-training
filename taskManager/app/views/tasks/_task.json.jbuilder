json.extract! task, :id, :task_name, :description, :user_id, :deadline, :priority, :status, :created_at, :updated_at
json.url task_url(task, format: :json)
