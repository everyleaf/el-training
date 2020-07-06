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

    context '項目リンクを押下した場合' do
      let!(:taskA) { create(:task, title: 'TASKA', due: Date.today) }
      let!(:taskB) { create(:task, title: 'TASKB', due: Date.today + 10) }
      let!(:taskC) { create(:task, title: 'TASKC', due: Date.today + 20) }

      context '期限の項目リンクを押下した場合' do
        context 'タスクが期限の降順でソートされていない場合' do
          it '期限の降順でソートされる' do
            # 一覧画面の初期表示時は、タスクの作成日順降順でソートされている
            visit root_path
            click_link '期限'

            expect(page.body.index(taskA.title)).to be > page.body.index(taskB.title)
            expect(page.body.index(taskB.title)).to be > page.body.index(taskC.title)
          end
        end

        context 'タスクが期限の降順でソートされている場合' do
          it '期限の昇順でソートされる' do
            # 一覧画面の初期表示時は、タスクの作成日順降順でソートされている
            visit root_path
            click_link '期限' # 期限の降順でソートされている状態を作る
            click_link '期限'

            expect(page.body.index(taskA.title)).to be < page.body.index(taskB.title)
            expect(page.body.index(taskB.title)).to be < page.body.index(taskC.title)
          end
        end
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
      select '高', from: 'task_priority'
      select '未着手', from: 'task_status'
      fill_in 'task_due', with: Date.current
      fill_in 'task_description', with: 'NEW TASK'
    end

    context '正常な値が入力された場合' do
      before do
        fill_in 'task_title', with: 'NEW TASK'
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

    context '異常な値が入力された場合' do
      context 'タイトルが空欄の場合' do
        it 'タイトルを入力してくださいとのメッセージが表示される' do
          fill_in 'task_title', with: ''
          click_button '送信'
          expect(page).to have_content 'タイトルを入力してください'
        end
      end

      context 'タイトルに最大文字数を超過した値が入力された場合' do
        it 'タイトルは20文字以内で入力してくださいとのメッセージが表示される' do
          fill_in 'task_title', with: '123456789123456789123456789'
          click_button '送信'
          expect(page).to have_content 'タイトルは20文字以内で入力してください'
        end
      end
    end
  end

  describe '#update' do
    before do
      visit edit_task_path(task.id)
      select '中', from: 'task_priority'
      select '完了', from: 'task_status'
      fill_in 'task_due', with: Date.current
      fill_in 'task_description', with: 'EDIT TASK'
    end

    context '正常な値が入力された場合' do
      before do
        fill_in 'task_title', with: 'EDIT TASK'
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

    context '異常な値が入力された場合' do
      context 'タイトルが空欄の場合' do
        it 'タイトルを入力してくださいとのメッセージが表示される' do
          fill_in 'task_title', with: ''
          click_button '送信'
          expect(page).to have_content 'タイトルを入力してください'
        end
      end

      context 'タイトルに最大文字数を超過した値が入力された場合' do
        it 'タイトルは20文字以内で入力してくださいとのメッセージが表示される' do
          fill_in 'task_title', with: '123456789123456789123456789'
          click_button '送信'
          expect(page).to have_content 'タイトルは20文字以内で入力してください'
        end
      end
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
