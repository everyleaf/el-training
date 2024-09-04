require 'rails_helper'

RSpec.describe Task, type: :system do
  describe '#index' do
    context "when task doesn't exist" do
      before { visit root_path }

      it "doesn't show any task" do
        expect(page).to have_no_button 'Delete'
      end
    end

    context 'when one task exists' do
      let!(:task_1) { create(:task) }

      before { visit root_path }

      it 'shows one task' do
        expect(page).to have_content task_1.title
        expect(page).to have_link task_1.title, href: task_path(task_1)
        expect(page).to have_button 'Delete'
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

    context 'when task is filtered' do
      tc = TasksController.new
      sm = tc.get_status_map

      let!(:tasks) { create_list(:task, 5) }

      before { visit root_path }

      it 'search by title' do
        fill_in 'query', with: 'ThisIsTitle3'
        click_on 'btn-search'

        expect(current_path).to eq root_path
        expect(page).to have_selector('tbody tr', count: 1)
      end

      it 'search by status' do
        # add extra items with various status
        create(:task, :status => Constants::STATUS_NOT_STARTED)
        create_list(:task, 3, status: Constants::STATUS_IN_PROGRESS)
        create_list(:task, 2, status: Constants::STATUS_COMPLETED)
        select sm[Constants::STATUS_COMPLETED], from: 'search-status'
        click_on 'btn-search'

        expect(current_path).to eq root_path
        expect(page).to have_selector('tbody tr', count: 2)
      end

      it 'search by title and status' do
        # add extra items with various status
        create(:task, status: Constants::STATUS_IN_PROGRESS)
        create(:task, status: Constants::STATUS_COMPLETED)
        create(:task, title: 'some random title', status: Constants::STATUS_COMPLETED)
        fill_in 'query', with: 'rand'
        select sm[Constants::STATUS_COMPLETED], from: 'search-status'
        click_on 'btn-search'

        expect(current_path).to eq root_path
        expect(page).to have_selector('tbody tr', count: 1)
      end
    end
  end

  describe '#create' do
    context 'when submit a new task' do
      before { visit root_path }

      sm = TasksController.new.get_status_map

      it 'creates a task successfully' do
        new_title = 'test title 1'
        new_description = 'test description 1'
        new_due_date_at = '2024-08-31'
        new_status = Constants::STATUS_IN_PROGRESS
        fill_in 'task[title]', with: new_title
        fill_in 'task[description]', with: new_description
        fill_in 'task[due_date_at]', with: new_due_date_at
        select sm[new_status], from: 'task[status]'
        click_on 'Create'

        # redirected back to root page
        expect(current_path).to eq root_path
        expect(page).to have_content '作成に成功しました'

        # make sure new task is there
        expect(page).to have_content new_title
        expect(page).to have_content new_due_date_at
        expect(page).to have_content sm[new_title]
      end

      it 'creates a task successfully w/ minimum fields' do
        new_title = 'test title 1'
        new_description = 'test description 1'
        new_due_date_at = '2024/08/31'
        fill_in 'task[title]', with: new_title
        fill_in 'task[description]', with: new_description
        click_on 'Create'

        # redirected back to root page
        expect(current_path).to eq root_path
        expect(page).to have_content '作成に成功しました'

        # make sure new task is there
        expect(page).to have_content new_title
        expect(page).to have_content sm[Constants::STATUS_NOT_STARTED]
      end

      it 'failed to create a task due to blank title' do
        fill_in 'task[title]', with: ''
        click_on 'Create'

        expect(current_path).to eq tasks_path
        expect(page).to have_content '作成に失敗しました'
      end

      it 'failed to create a task due to too long title' do
        fill_in 'task[title]', with: SecureRandom.alphanumeric(51)
        click_on 'Create'

        expect(current_path).to eq tasks_path
        expect(page).to have_content '作成に失敗しました'
      end

      it 'failed to create a task due to too long description' do
        fill_in 'task[title]', with: 'ThisIsTitle'
        fill_in 'task[description]', with: SecureRandom.alphanumeric(501)
        click_on 'Create'

        expect(current_path).to eq tasks_path
        expect(page).to have_content '作成に失敗しました'
      end

      it 'failed to create a task due to invalid due date' do
        fill_in 'task[title]', with: 'ThisIsTitle'
        fill_in 'task[due_date_at]', with: '2024/99/99'
        click_on 'Create'

        expect(current_path).to eq tasks_path
        expect(page).to have_content '作成に失敗しました'
      end

      it 'failed to create a task due to invalid due date format' do
        fill_in 'task[title]', with: 'ThisIsTitle'
        fill_in 'task[due_date_at]', with: 'invalid_format!?'
        click_on 'Create'

        expect(current_path).to eq tasks_path
        expect(page).to have_content '作成に失敗しました'
      end
    end
  end

  describe '#show' do
    context 'when there is a valid task' do
      let!(:task_1) { create(:task) }

      it 'shows details and edit link' do
        sm = TasksController.new.get_status_map

        visit task_path(task_1)
        expect(page).to have_content task_1.title
        expect(page).to have_content task_1.description
        expect(page).to have_content sm[task_1.status]
        expect(page).to have_link 'Edit', href: edit_task_path(task_1)
        expect(current_path).to eq task_path(task_1)
        click_link 'Edit'
        expect(current_path).to eq edit_task_path(task_1)
      end
    end

    context 'when record not found' do
      it 'redirected to root path due to not existing id' do
        visit task_path(99999)
        expect(current_path).to eq error_path(404)
      end

      it 'redirected to root path due to invalid id format' do
        visit task_path('invalid_path')
        expect(current_path).to eq error_path(404)
      end
    end
  end

  describe '#edit' do
    context 'when there is a valid task' do
      let!(:task_1) { create(:task) }

      it 'shows edit form' do
        visit edit_task_path(task_1)
        expect(page).to have_field('task[title]', with: task_1.title)
        expect(page).to have_field('task[description]', with: task_1.description)
        expect(page).to have_field('task[due_date_at]', with: task_1.due_date_at)
        expect(page).to have_field('task[status]', with: task_1.status)
        expect(page).to have_button 'Update'

        expect(current_path).to eq edit_task_path(task_1)
      end
    end

    context 'when record not found' do
      it 'redirected to root path due to not existing id' do
        visit edit_task_path(99999)
        expect(current_path).to eq error_path(404)
      end

      it 'redirected to root path due to invalid id format' do
        visit edit_task_path('invalid_path')
        expect(current_path).to eq error_path(404)
      end
    end
  end

  describe '#update' do
    context 'when update a task' do
      let!(:task_1) { create(:task) }

      # success case
      it 'updated a task successfully' do
        visit edit_task_path(task_1)
        tc = TasksController.new
        sm = tc.get_status_map

        # update a task
        updated_title = 'title 1 updated'
        updated_description = 'description 1 updated'
        updated_due_date_at = '2024/08/31'
        updated_status = Constants::STATUS_COMPLETED
        fill_in 'task[title]', with: updated_title
        fill_in 'task[description]', with: updated_description
        fill_in 'task[due_date_at]', with: updated_due_date_at
        select sm[updated_status], from: 'task[status]'
        click_on 'Update'

        # redirected to root
        expect(current_path).to eq root_path
        expect(page).to have_content '更新に成功しました'

        # make sure the task was updated
        expect(page).to have_content updated_title
        expect(page).to have_content sm[updated_status]
      end

      # failure cases
      it 'failed to update a task due to blank title' do
        visit edit_task_path(task_1)

        fill_in 'task[title]', with: ''
        click_on 'Update'

        expect(current_path).to eq task_path(task_1)
        expect(page).to have_content '更新に失敗しました'
      end

      it 'failed to update a task due to too long title' do
        visit edit_task_path(task_1)
        fill_in 'task[title]', with: SecureRandom.alphanumeric(51)
        fill_in 'task[description]', with: 'ThisIsDescription'
        click_on 'Update'

        expect(current_path).to eq task_path(task_1)
        expect(page).to have_content '更新に失敗しました'
      end

      it 'failed to update a task due to too long description' do
        visit edit_task_path(task_1)

        fill_in 'task[title]', with: 'ThisIsTitle'
        fill_in 'task[description]', with: SecureRandom.alphanumeric(501)
        click_on 'Update'
        expect(current_path).to eq task_path(task_1)
        expect(page).to have_content '更新に失敗しました'
      end

      it 'failed to update a task due to invalid due date' do
        visit edit_task_path(task_1)

        fill_in 'task[title]', with: 'ThisIsTitle'
        fill_in 'task[due_date_at]', with: '2024/99/99'
        click_on 'Update'
        expect(current_path).to eq task_path(task_1)
        expect(page).to have_content '更新に失敗しました'
      end

      it 'failed to update a task due to invalid due date format' do
        visit edit_task_path(task_1)

        fill_in 'task[title]', with: 'ThisIsTitle'
        fill_in 'task[due_date_at]', with: 'invalid_format!?'
        click_on 'Update'
        expect(current_path).to eq task_path(task_1)
        expect(page).to have_content '更新に失敗しました'
      end
    end
  end

  describe '#destroy' do
    let!(:task_1) { create(:task) }
    before { visit root_path }

    context 'when delete a task' do
      it 'deletes a task successfully' do
        expect(page).to have_content task_1.title
        click_on 'Delete'

        # redirected to root
        expect(current_path).to eq root_path
        expect(page).to have_content '削除に成功しました'

        # make sure the task was deleted
        expect(page).to have_no_content task_1.title
        expect(page).to have_no_button 'Delete'
      end
    end
  end
end
