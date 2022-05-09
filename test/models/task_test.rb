require 'test_helper'

class TaskTest < ActiveSupport::TestCase
  def setup
    @task = Task.new
  end

  test 'parameters validation' do
    assert_not @task.valid?

    @task.name        = 'example task'
    @task.description = 'abstract text'
    @task.start_date  = Time.zone.today
    @task.progress    = 0

    assert @task.valid?
  end
end
