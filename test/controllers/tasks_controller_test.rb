require 'test_helper'

class TasksControllerTest < ActionDispatch::IntegrationTest
  test 'should get show' do
    get tasks_show_url
    assert_response :success
  end

  test 'should get index' do
    get tasks_index_url
    assert_response :success
  end
end
