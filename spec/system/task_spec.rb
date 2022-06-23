require 'rails_helper'

RSpec.describe 'Tasks', type: :system do
  # テスト用タスク
  let(:task) { create(:task) }

  # rubocop:disable RSpec/ExampleLength, RSpec/MultipleExpectations
  describe 'タスクの作成' do
    # タスク一覧ページを表示
    visit tasks_path

    # 作成リンクをクリック
    click_on 'タスクを作成'

    context 'description以外の入力フォームを全て埋める' do
      it 'タスクの作成に成功する' do
        # タスク一覧ページを表示
        visit tasks_path

        # 作成リンクをクリック
        click_on 'タスクを作成'
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

        # 正しい内容でタスクが作成されていることを確認
        expect(page).to have_content 'sample task'
        expect(page).to have_content "#{today.mon}/#{today.mday}"
        expect(page).to have_content '3'
        expect(page).to have_content '未着手'
        expect(page).to have_content '低'
      end
    end
  end

  describe 'タスクの更新' do
    # 詳細ページに移動
    visit task_path(task)

    # 正しい詳細ページに飛んだことを確認
    expect(page).to have_content 'test task'
    expect(page).to have_link    '編集'
    expect(page).to have_button  'タスクを削除'

    # 編集ページに遷移
    click_link '編集'

    context 'Nameを書き換えて更新' do
      it '更新に成功する' do
        # 新しい名前にして更新
        fill_in      'Name', with: 'updated task'
        click_button 'Save changes'

        # 更新成功
        expect(page).to have_content 'Task Updated Successfully!'

        # 詳細ページにいることを確認
        expect(page).to have_link   '編集'
        expect(page).to have_button 'タスクを削除'

        # タスク名が更新されていることを確認
        expect(page).to have_content 'updated task'
      end
    end

    context 'Nameを空欄にして更新' do
      it '更新に失敗する' do
        # 名前を空欄にして更新しようとすると失敗
        fill_in      'Name', with: ''
        click_button 'Save changes'
        expect(page).to have_content "Name can't be blank"
      end
    end
  end

  describe 'タスクの削除' do
    # 詳細ページに移動
    visit task_path(task)

    context '削除ボタンからタスクを削除する' do
      it '削除が成功する' do
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

  # rubocop:enable RSpec/ExampleLength, RSpec/MultipleExpectations
end
