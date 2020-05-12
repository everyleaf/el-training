require 'rails_helper'

describe 'task', type: :system do
  let!(:task) { create_list(:task, 5) }

  describe '#index' do
    context 'accress root' do
      before { visit tasks_path }

      it 'should be success to access the task list' do
        expect(page).to have_content 'タスク一覧'
        expect(page).to have_content '名前'
        expect(page).to have_content '説明'
      end

      it 'tasks should be arrange in descending date order' do
        expect(page.all('.task-name').map(&:text)).to eq tasks.map { |h| h[:name] }.reverse
      end
    end
  end

  describe '#new (GET /tasks/new)' do
    context 'name is more than one letter' do
      it 'should be success' do
        visit new_task_path

        fill_in '名前', with: 'huga'
        fill_in '説明', with: 'fuga'

        click_on '登録する'
        expect(page).to have_content 'タスクを作成しました'
      end
    end
  end

  describe '#edit (GET /tasks/:id/edit)' do
    context 'name is more than one letter' do
      it 'should be success' do
        visit edit_task_path(tasks[0].id)

        fill_in '名前', with: 'hogehoge'
        fill_in '説明', with: 'fugaguga'

        click_on '更新する'
        expect(page).to have_content 'タスクを更新しました'
      end
    end
  end

  describe '#show (GET /tasks/:id)' do
    context 'access the detail page' do
      it 'should be success' do
        visit task_path(tasks[0].id)

        expect(page).to have_content 'タスク詳細'
        expect(page).to have_content tasks[0].name
        expect(page).to have_content tasks[0].description
      end
    end
  end

  describe '#delete (DELETE /tasks/:id)', js: true do
    context 'push delete button from detail page' do
      it 'should be success to delete the task' do
        visit task_path(tasks[0].id)

        # confirm dialog
        page.dismiss_confirm do
          click_on '削除'
          expect(page.driver.browser.switch_to.alert.text).to eq 'タスクを削除しますか？'
        end

        page.accept_confirm do
          click_on '削除'
        end

        expect(page).to have_content 'タスクを削除しました'
      end
    end
  end
end
