require 'rails_helper'

RSpec.describe 'Tasks', type: :system do
  let!(:task) { create(:task) }

  describe '#index' do
    before do
      visit root_path
    end

    it '登録済みタスクの一覧が表示される' do
      expect(page).to have_content task.title
      expect(page).to have_content '中'
      expect(page).to have_content '未着手'
      expect(page).to have_content task.due
    end

    context '複数のタスクが表示されている場合' do
      let!(:old_task) { create(:task, title: 'OLD', created_at: Time.now) }
      let!(:new_task) { create(:task, title: 'NEW', created_at: Time.now + 1.second) }

      it 'タスクが作成日の降順で表示されている' do
        visit current_path
        expect(new_task.created_at.time > old_task.created_at.time).to be true
        expect(page.body.index(new_task.title)).to be < page.body.index(old_task.title)
      end
    end
  end

  describe '#show' do
    before do
      visit task_path(task.id)
    end

    it '登録済みタスクの詳細情報が1件表示される' do
      expect(page).to have_content task.title
      expect(page).to have_content task.description
      expect(page).to have_content '中'
      expect(page).to have_content '未着手'
      expect(page).to have_content task.due
    end
  end

  describe '#create' do
    before do
      visit new_task_path
      fill_in 'task_title', with: 'NEW TASK'
      select '高', from: 'task_priority'
      select '未着手', from: 'task_status'
      fill_in 'task_due', with: Date.current
      fill_in 'task_description', with: 'NEW TASK'
      click_button '送信'
    end

    it 'タスク一覧画面に遷移し、新規タスクが一覧に表示されている' do
      expect(current_path).to eq(tasks_path)
      expect(page).to have_content 'NEW TASK'
      expect(page).to have_content '高'
      expect(page).to have_content '未着手'
      expect(page).to have_content Date.current
    end

    it 'タスク一覧画面にタスク登録が成功したとのメッセージが表示される' do
      expect(page).to have_content 'タスクが登録されました'
    end
  end

  describe '#update' do
    before do
      visit edit_task_path(task.id)
      fill_in 'task_title', with: 'EDIT TASK'
      select '中', from: 'task_priority'
      select '完了', from: 'task_status'
      fill_in 'task_due', with: Date.current
      fill_in 'task_description', with: 'EDIT TASK'
      click_button '送信'
    end

    it 'タスク一覧画面に遷移し、編集されたタスクが一覧に表示されている' do
      expect(current_path).to eq(tasks_path)
      expect(page).to have_content 'EDIT TASK'
      expect(page).to have_content '中'
      expect(page).to have_content '完了'
      expect(page).to have_content Date.current
    end

    it 'タスク一覧画面にタスクの編集が成功したとのメッセージが表示される' do
      expect(page).to have_content 'タスクが編集されました'
    end
  end

  describe '#destroy' do
    before do
      visit root_path
    end

    it 'ダイアログが表示される' do
      page.dismiss_confirm do
        click_link '削除'
        expect(page.driver.browser.switch_to.alert.text).to eq 'タスクを削除しますか？'
      end
    end

    it '削除したタスクが一覧画面に表示されていない且つ、タスクの削除が成功したとのメッセージが表示される' do
      page.accept_confirm do
        click_link '削除'
      end
      expect(page).not_to have_content task.title
      expect(page).not_to have_content task.priority
      expect(page).not_to have_content task.status
      expect(page).not_to have_content task.due
      expect(page).to have_content 'タスクを削除しました'
    end
  end
end
