require 'rails_helper'

RSpec.describe Task, type: :system do
  describe '#index' do

    context "when task doesn't exist" do
      before { visit root_path }

      it "doesn't show any task" do
        expect(page).to have_no_button "Delete"
      end
    end

    context 'when one task exists' do
      let!(:task_1) { create(:task) }

      before { visit root_path }

      it 'shows one task' do
        expect(page).to have_content task_1.title
        expect(page).to have_content task_1.description
        expect(page).to have_link task_1.title, href: task_path(task_1)
        expect(page).to have_button "Delete"
      end
    end

    context 'when multiple tasks exist' do
      let!(:tasks) { create_list(:task, 3) }

      before { visit root_path }

      it 'shows task list in created_at descending order' do
        expect(page).to have_selector('tbody tr', count: 3)
        expect(page.all('tbody tr')[0]).to have_content(tasks[2].title)
        expect(page.all('tbody tr')[1]).to have_content(tasks[1].title)
        expect(page.all('tbody tr')[2]).to have_content(tasks[0].title)
      end
    end
  end

  describe "#create" do
    context 'when submit a new task' do
      before { visit root_path }

      it "creates a task successfully" do
        new_title = 'test title 1'
        new_description = 'test description 1'
        fill_in 'task_title', with: new_title
        fill_in 'task_description', with: new_description
        click_on 'Create'

        # redirected back to root page
        expect(current_path).to eq root_path
        expect(page).to have_content TasksController::MSG_CREATE_SUCCESS

        # make sure new task is there
        expect(page).to have_content new_title
        expect(page).to have_content new_description
      end

      # Failure case will be added when validation is added.
    end
  end

  describe "#show" do
    context "when there is a valid task" do
      let!(:task_1) { create(:task) }

      it "shows details and edit link" do
        visit task_path(task_1)
        expect(page).to have_content task_1.title
        expect(page).to have_content task_1.description
        expect(page).to have_link "Edit", href: edit_task_path(task_1)
        expect(current_path).to eq task_path(task_1)
        click_link "Edit"
        expect(current_path).to eq edit_task_path(task_1)
      end
    end

    context "when record not found" do
      it "redirected to root path due to not existing id" do
        visit task_path(99999)
        expect(current_path).to eq error_path(404)
      end

      it "redirected to root path due to invalid id format" do
        visit task_path("invalid_path")
        expect(current_path).to eq error_path(404)
      end
    end
  end

  describe "#edit" do
    context "when there is a valid task" do
      let!(:task_1) { create(:task) }

      it "shows edit form" do
        visit edit_task_path(task_1)
        expect(page).to have_field("task_title", with: task_1.title)
        expect(page).to have_field("task_description", with: task_1.description)
        expect(page).to have_button "Update"

        expect(current_path).to eq edit_task_path(task_1)
      end
    end

    context "when record not found" do
      it "redirected to root path due to not existing id" do
        visit edit_task_path(99999)
        expect(current_path).to eq error_path(404)
      end

      it "redirected to root path due to invalid id format" do
        visit edit_task_path("invalid_path")
        expect(current_path).to eq error_path(404)
      end
    end
  end

  describe "#update" do
    context "when update a task" do
      let!(:task_1) { create(:task) }

      it "updated a task successfully" do
        visit edit_task_path(task_1)

        # update a task
        updated_title = 'title 1 updated'
        updated_description = 'description 1 updated'
        fill_in 'task_title', with: updated_title
        fill_in 'task_description', with: updated_description
        click_on "Update"

        # redirected to root
        expect(current_path).to eq root_path
        expect(page).to have_content TasksController::MSG_UPDATE_SUCCESS

        # make sure the task was updated
        expect(page).to have_content updated_title
        expect(page).to have_content updated_description
      end

      # Failure case will be added when validation is added.
    end
  end

  describe "#destroy" do
    let!(:task_1) { create(:task) }
    before { visit root_path }

    context 'when delete a task' do
      it 'deletes a task successfully' do
        expect(page).to have_content task_1.title
        expect(page).to have_content task_1.description
        click_on 'Delete'

        # redirected to root
        expect(current_path).to eq root_path
        expect(page).to have_content TasksController::MSG_DELETE_SUCCESS

        # make sure the task was deleted
        expect(page).to have_no_content task_1.title
        expect(page).to have_no_content task_1.description
        expect(page).to have_no_button "Delete"
      end
    end
  end

end
