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

    context 'description以外の入力フォームを全て埋めたとき' do
      it 'タスクの作成に成功する' do
        # フォームを埋める
        today = Time.zone.today
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

    context '削除ボタンを押すと' do
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
end
