require 'test_helper'

class TaskTest < ActiveSupport::TestCase
  def setup
    @task = Task.new
  end

  test 'parameters validation' do
    assert_not @task.valid?

    @task.task_name = 'example task'
    @task.abstract_text = 'abstract text'
    # @start_date = Date.parse('2022-05-03')
    @task.status = 0
    assert @task.valid?
  end
end
