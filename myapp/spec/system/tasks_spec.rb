require 'rails_helper'

RSpec.describe 'Tasks', type: :system do
  describe 'Tasklist' do
    shared_examples 'Checking component' do
      it 'displays common components' do
        expect(page).to have_selector('h1', text: 'Tasks')
        expect(page).to have_link('Add')
        expect(page).to have_button('Login')
      end
    end

    context 'When no tasks exist' do
      before do
        visit tasks_path
      end

      it_behaves_like 'Checking component'
      it 'displays "no tasks" message' do
        expect(page).to have_content('タスクがありません。')
      end
    end

    context 'When any tasks exist' do
      before do
        @task1 = Task.create!(title: 'ryu title1', details: 'ryu deailts1')
        @task2 = Task.create!(title: 'ryu title2', details: 'ryu deailts2')
        visit tasks_path
      end

      it_behaves_like 'Checking component'
      it 'displays Items' do
        expect(page).to have_field('Search')
        expect(page).to have_selector('tr>th', text: 'Title')
        expect(page).to have_link(@task1.title)
        expect(page).to have_link(@task2.title)
      end
    end
  end

  describe 'New task' do
    context 'Initial display' do
      before do
        visit tasks_path
        click_link 'Add'
      end

      it 'display components' do
        expect(page).to have_selector('h1', text: 'New')
        expect(page).to have_field('Title(Required)', readonly: false)
        expect(page).to have_field('Details', readonly: false)
        expect(page).to have_link('Cancel')
        expect(page).to have_button('Create')
      end
    end

    context 'When cancelling' do
      before do
        visit new_task_path
        click_link 'Cancel'
      end

      it 'goes back to the Task page' do
        expect(page).to have_selector('h1', text: 'Tasks')
      end
    end

    context 'When the task is valid' do
      before do
        visit new_task_path
        fill_in 'Title', with: 'New ryu title1'
        fill_in 'Details', with: 'New ryu Details1'
        click_button 'Create'
      end

      it 'shows a success message on the Tasks page' do
        expect(Task.count).to eq(1)
        expect(Task.last.title).to eq('New ryu title1')
        expect(Task.last.details).to eq('New ryu Details1')
        expect(page).to have_selector('h1', text: 'Tasks')
        expect(page).to have_content('タスク登録に成功しました。')
      end
    end

    context 'When the task is invalid' do
      before do
        visit new_task_path
        fill_in 'Title', with: '  '
        fill_in 'Details', with: 'New ryu Details1'
        click_button 'Create'
      end
      it 'shows a error message on the New page' do
        expect(Task.count).to eq(0)
        expect(page).to have_selector('h1', text: 'New')
        expect(page).to have_content('タスク登録に失敗しました。')
      end
    end
  end

  describe 'Show task' do
    let!(:task) { Task.create!(title: 'ryu title3', details: 'ryu deailts3') }

    context 'Initial display' do
      before do
        visit tasks_path
        click_link task.title
      end
      it 'display components' do
        expect(page).to have_selector('h1', text: 'Show')
        expect(page).to have_field('Title(Required)', with: task.title, readonly: true)
        expect(page).to have_field('Details', with: task.details, readonly: true)
        expect(page).to have_link('Cancel')
        expect(page).to have_link('Edit')
      end
    end

    context 'When cancelling' do
      before do
        visit task_path(task)
        click_link 'Cancel'
      end

      it 'goes back to the Task page' do
        expect(page).to have_selector('h1', text: 'Tasks')
      end
    end

    context 'When deleting the Task' do
      before do
        visit task_path(task)
        click_button 'Delete'
      end

      it 'shows a success message on the Tasks page' do
        expect(Task.count).to eq(0)
        expect(page).to have_selector('h1', text: 'Tasks')
        expect(page).to have_content('タスク削除に成功しました。')
      end
    end
  end

  describe 'Edit task' do
    let!(:task) { Task.create!(title: 'ryu title3', details: 'ryu deailts3') }

    context 'Initial display' do
      before do
        visit task_path(task)
        click_link 'Edit'
      end
      it 'display components' do
        expect(page).to have_selector('h1', text: 'Edit')
        expect(page).to have_field('Title(Required)', with: task.title, readonly: false)
        expect(page).to have_field('Details', with: task.details, readonly: false)
        expect(page).to have_link('Cancel')
        expect(page).to have_button('Update')
      end
    end

    context 'When cancelling' do
      before do
        visit edit_task_path(task)
        click_link 'Cancel'
      end

      it 'goes back to the Task page' do
        expect(page).to have_selector('h1', text: 'Tasks')
      end
    end

    context 'When deleting the Task' do
      before do
        visit edit_task_path(task)
        click_button 'Delete'
      end

      it 'shows a success message on the Tasks page' do
        expect(Task.count).to eq(0)
        expect(page).to have_selector('h1', text: 'Tasks')
        expect(page).to have_content('タスク削除に成功しました。')
      end
    end

    context 'When updating the Task with valid data' do
      let!(:valid_params) { { title: 'Ok Ok Ok Title', details: 'Ok Ok Ok Details' } }
      before do
        visit edit_task_path(task)
        fill_in 'Title', with: valid_params[:title]
        fill_in 'Details', with: valid_params[:details]
        click_button 'Update'
      end

      it 'shows a success message on the Tasks page' do
        expect(Task.count).to eq(1)
        expect(Task.last.title).to eq(valid_params[:title])
        expect(Task.last.details).to eq(valid_params[:details])
        expect(page).to have_selector('h1', text: 'Tasks')
        expect(page).to have_content('タスク更新に成功しました。')
      end
    end

    context 'When updating the Task with invalid data' do
      before do
        visit edit_task_path(task)
        fill_in 'Title', with: ''
        fill_in 'Details', with: 'NG Case'
        click_button 'Update'
      end

      it 'shows a error message on the Edit page' do
        expect(Task.count).to eq(1)
        expect(page).to have_selector('h1', text: 'Edit')
        expect(page).to have_content('タスク更新に失敗しました。')
      end
    end
  end
end
