require "test_helper"

class TasksControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get tasks_new_url
    assert_response :success
  end
end
