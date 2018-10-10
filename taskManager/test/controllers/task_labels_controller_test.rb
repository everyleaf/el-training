require 'test_helper'

class TaskLabelsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @task_label = task_labels(:one)
  end

  test "should get index" do
    get task_labels_url
    assert_response :success
  end

  test "should get new" do
    get new_task_label_url
    assert_response :success
  end

  test "should create task_label" do
    assert_difference('TaskLabel.count') do
      post task_labels_url, params: { task_label: { label_id: @task_label.label_id, task_id: @task_label.task_id } }
    end

    assert_redirected_to task_label_url(TaskLabel.last)
  end

  test "should show task_label" do
    get task_label_url(@task_label)
    assert_response :success
  end

  test "should get edit" do
    get edit_task_label_url(@task_label)
    assert_response :success
  end

  test "should update task_label" do
    patch task_label_url(@task_label), params: { task_label: { label_id: @task_label.label_id, task_id: @task_label.task_id } }
    assert_redirected_to task_label_url(@task_label)
  end

  test "should destroy task_label" do
    assert_difference('TaskLabel.count', -1) do
      delete task_label_url(@task_label)
    end

    assert_redirected_to task_labels_url
  end
end
