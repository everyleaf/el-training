require "application_system_test_case"

class TaskLabelsTest < ApplicationSystemTestCase
  setup do
    @task_label = task_labels(:one)
  end

  test "visiting the index" do
    visit task_labels_url
    assert_selector "h1", text: "Task Labels"
  end

  test "creating a Task label" do
    visit task_labels_url
    click_on "New Task Label"

    fill_in "Label", with: @task_label.label_id
    fill_in "Task", with: @task_label.task_id
    click_on "Create Task label"

    assert_text "Task label was successfully created"
    click_on "Back"
  end

  test "updating a Task label" do
    visit task_labels_url
    click_on "Edit", match: :first

    fill_in "Label", with: @task_label.label_id
    fill_in "Task", with: @task_label.task_id
    click_on "Update Task label"

    assert_text "Task label was successfully updated"
    click_on "Back"
  end

  test "destroying a Task label" do
    visit task_labels_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Task label was successfully destroyed"
  end
end
