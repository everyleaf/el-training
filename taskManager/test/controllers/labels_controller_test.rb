require 'test_helper'

class LabelsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @label = labels(:one)
  end

  test "should get index" do
    get labels_url
    assert_response :success
  end

  test "should get new" do
    get new_label_url
    assert_response :success
  end

  test "should create label" do
    assert_difference('Label.count') do
      post labels_url, params: { label: { label_name: @label.label_name } }
    end

    assert_redirected_to label_url(Label.last)
  end

  test "should show label" do
    get label_url(@label)
    assert_response :success
  end

  test "should get edit" do
    get edit_label_url(@label)
    assert_response :success
  end

  test "should update label" do
    patch label_url(@label), params: { label: { label_name: @label.label_name } }
    assert_redirected_to label_url(@label)
  end

  test "should destroy label" do
    assert_difference('Label.count', -1) do
      delete label_url(@label)
    end

    assert_redirected_to labels_url
  end
end
