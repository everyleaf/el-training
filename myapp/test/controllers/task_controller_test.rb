require 'test_helper'

class TaskControllerTest < ActionDispatch::IntegrationTest
  test "should get list" do
    get task_list_url
    assert_response :success
  end

end
