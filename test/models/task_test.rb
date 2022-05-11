require 'test_helper'

class TaskTest < ActiveSupport::TestCase
  def setup
    @task = Task.new
  end

  test 'parameters validation' do
    assert_not @task.valid?

    @task.name           = 'example task'
    @task.start_date     = Time.zone.today
    @task.necessary_days = 2
    @task.priority       = 1

    assert @task.valid?
  end
end
