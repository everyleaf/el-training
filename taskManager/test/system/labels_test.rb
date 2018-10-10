require "application_system_test_case"

class LabelsTest < ApplicationSystemTestCase
  setup do
    @label = labels(:one)
  end

  test "visiting the index" do
    visit labels_url
    assert_selector "h1", text: "Labels"
  end

  test "creating a Label" do
    visit labels_url
    click_on "New Label"

    fill_in "Label Name", with: @label.label_name
    click_on "Create Label"

    assert_text "Label was successfully created"
    click_on "Back"
  end

  test "updating a Label" do
    visit labels_url
    click_on "Edit", match: :first

    fill_in "Label Name", with: @label.label_name
    click_on "Update Label"

    assert_text "Label was successfully updated"
    click_on "Back"
  end

  test "destroying a Label" do
    visit labels_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Label was successfully destroyed"
  end
end
