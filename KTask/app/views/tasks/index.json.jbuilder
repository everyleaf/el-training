# frozen_string_literal: true

json.array! @tasks, partial: 'tasks/task', as: :task
