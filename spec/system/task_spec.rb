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

  describe 'タスクの並び替え' do
    before do
      # タスク一覧ページを表示
      visit tasks_path

      # テストデータ
      create(:task, name: 'a', priority: 2)
      create(:task, name: 'b', priority: 0)
      create(:task, name: 'c', priority: 1)
    end

    context '並び替えたいパラメータを1回だけ選択すると' do
      it 'そのパラメータで昇順に並び替えられる' do
        click_on '重要度'
        expect(current_url).to include('direction=ASC')

        tasks = page.all('.task')
        expect(tasks[0]).to have_content '低'
        expect(tasks[1]).to have_content '中'
        expect(tasks[2]).to have_content '高'
      end
    end

    context '同じパラメータを選択すると' do
      it '昇順と降順が入れ替わる' do
        # 最初は昇順に並べ替える
        click_on '重要度'
        expect(current_url).to include('direction=ASC')

        # もう一度押すと降順に並べ替えられる
        click_on '重要度'
        expect(current_url).to include('direction=DESC')

        # ページがレンダリングされるのを待つ
        # これがないとStaleElementReferenceErrorが発生
        sleep 1

        tasks = page.all('.task')
        expect(tasks[0]).to have_content '高'
        expect(tasks[1]).to have_content '中'
        expect(tasks[2]).to have_content '低'
      end
    end
  end
end
