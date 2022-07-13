require 'rails_helper'

RSpec.describe 'Tasks', type: :system do
  # テスト用タスク
  let(:task) { create(:task) }

  describe 'タスクの作成' do
    before do
      # タスク一覧ページを表示
      visit tasks_path

      # 作成リンクをクリック
      click_on 'タスクを作成'
    end

    let(:today) { Time.zone.today }

    context 'description以外の入力フォームを全て埋めたとき' do
      it 'タスクの作成に成功する' do
        # フォームを埋める
        fill_in 'Name',           with: 'sample task'
        fill_in 'Start date',     with: today
        fill_in 'Necessary days', with: 3
        choose  '未着手'
        choose  '低'

        # 作成実行
        click_button 'Create'

        # 作成成功
        expect(page).to have_content 'Task Created Successfully!'

        # indexページにいる
        expect(page).to have_content 'All tasks'
      end
    end

    context 'Nameを空のままタスクを作成しようとしたとき' do
      it 'タスクの作成に失敗する' do
        # フォームを埋める
        fill_in 'Name',           with: ''
        fill_in 'Start date',     with: today
        fill_in 'Necessary days', with: 3
        choose  '未着手'
        choose  '低'

        # 作成実行
        click_button 'Create'

        # 作成失敗
        expect(page).to have_content 'Failed to create task'

        # newページにいる
        expect(page).to have_content 'new task'
      end
    end
  end

  describe 'タスクの更新' do
    before do
      # 詳細ページに移動
      visit task_path(task)

      # 編集ページに遷移
      click_link '編集'
    end

    context 'Nameを書き換えて更新したとき' do
      it '更新に成功する' do
        # 新しい名前にして更新
        fill_in      'Name', with: 'updated task'
        click_button 'Save changes'

        # 更新成功
        expect(page).to have_content 'Task Updated Successfully!'

        # 詳細ページにいる
        expect(page).to have_link '一覧に戻る'

        # タスク名が更新されている
        expect(page).to have_content 'updated task'
      end
    end

    context 'Nameを空欄にして更新したとき' do
      it '更新に失敗する' do
        fill_in      'Name', with: ''
        click_button 'Save changes'

        expect(page).to have_content "Name can't be blank"
      end
    end
  end

  describe 'タスクの削除' do
    before do
      # 詳細ページに移動
      visit task_path(task)
    end

    context '削除ボタンを押したとき' do
      it 'タスクが削除される' do
        # 削除ボタンを押す
        click_button 'タスクを削除'

        # 確認のポップアップが表示される
        expect(page.accept_confirm).to eq '本当に削除しますか?'

        # 削除成功のメッセージが表示される
        expect(page).to have_content 'Task deleted Successfully'

        # 一覧ページにいる
        expect(page).to have_content 'All tasks'
      end
    end
  end

  describe 'タスクの検索' do
    before do
      # タスク一覧ページを表示
      visit tasks_path

      # テストデータ
      create(:task, name: 'a', priority: 0, progress: 0)
      create(:task, name: 'b', priority: 1, progress: 1)
      create(:task, name: 'c', priority: 2, progress: 2)
    end

    context '検索条件に該当するタスクが存在するとき' do
      it '該当するタスクのみ表示される' do
        
        uncheck('search_priority_中')
        uncheck('search_progress_完了')

        # このときタスクの検索条件は
        # (priority == 低 || 高) && (progress == 未着手 || 実行中)
        # task 'a' のみが条件に当てはまる

        click_on ('検索')

        # 表示されているタスクを取得
        tasks = page.all('.task')

        # 表示されているタスク数は1件
        expect(tasks.size).to eq(1)

        # 表示されているタスクは'a'
        expect(tasks[0]).to have_content '低'
      end
    end

    context '検索ボタンを押したとき' do
      it 'チェックボックスの状態は維持される' do
        
        # デフォルトでは全てのチェックボックスがチェックされている
        expect(page).to have_checked_field('search_priority_低')
        expect(page).to have_checked_field('search_priority_中')
        expect(page).to have_checked_field('search_priority_高')
        expect(page).to have_checked_field('search_progress_未着手')
        expect(page).to have_checked_field('search_progress_実行中')
        expect(page).to have_checked_field('search_progress_完了')

        #ある項目のチェックを外す
        uncheck('search_priority_中')
        uncheck('search_progress_未着手')
        uncheck('search_progress_完了')

        # 検索ボタンを押す
        click_on('検索')

        # 選択されていたものは選択されたまま
        expect(page).to have_checked_field('search_priority_低')
        expect(page).to have_checked_field('search_priority_高')
        expect(page).to have_checked_field('search_progress_実行中')

        # チェックが外れていたものはチェックが外れたまま
        expect(page).to have_unchecked_field('search_priority_中')
        expect(page).to have_unchecked_field('search_progress_未着手')
        expect(page).to have_unchecked_field('search_progress_完了')
      end
    end
  end
end
