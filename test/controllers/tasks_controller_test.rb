require 'test_helper'

class TasksControllerTest < ActionDispatch::IntegrationTest
<<<<<<< HEAD
  test 'should get new' do
    get tasks_new_url
=======
  test 'should get show' do
    get tasks_show_url
    assert_response :success
  end

  test 'should get index' do
    get tasks_index_url
>>>>>>> step8-1-create-task-view
    assert_response :success
  end
end
