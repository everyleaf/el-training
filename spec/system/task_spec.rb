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
        fill_in 'タスク名', with: 'sample task'
        fill_in '開始日', with: today
        fill_in '必要日数', with: 3
        choose  '未着手'
        choose  '低'

        # 作成実行
        click_button 'Create'

        # 作成成功
        expect(page).to have_content 'タスクを作成しました'

        # indexページにいる
        expect(page).to have_content 'タスク一覧'
      end
    end

    context 'Nameを空のままタスクを作成しようとしたとき' do
      it 'タスクの作成に失敗する' do
        # フォームを埋める
        fill_in 'タスク名', with: ''
        fill_in '開始日', with: today
        fill_in '必要日数', with: 3
        choose  '未着手'
        choose  '低'

        # 作成実行
        click_button 'Create'

        # 作成失敗
        expect(page).to have_content 'タスクの作成に失敗しました'

        # newページにいる
        expect(page).to have_content 'タスク作成'
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
        fill_in      'タスク名', with: 'updated task'
        click_button '変更を保存'

        # 更新成功
        expect(page).to have_content 'タスクを更新しました'

        # 詳細ページにいる
        expect(page).to have_link '一覧に戻る'

        # タスク名が更新されている
        expect(page).to have_content 'updated task'
      end
    end

    context 'Nameを空欄にして更新したとき' do
      it '更新に失敗する' do
        fill_in      'タスク名', with: ''
        click_button '変更を保存'

        expect(page).to have_content 'タスク名を入力してください'
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
        expect(page).to have_content 'タスクを削除しました'

        # 一覧ページにいる
        expect(page).to have_content 'タスク一覧'
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
        sleep 3

        tasks = page.all('.task')
        expect(tasks[0]).to have_content '高'
        expect(tasks[1]).to have_content '中'
        expect(tasks[2]).to have_content '低'
      end
    end
  end

  describe 'ページネーション' do
    let(:today) { Time.zone.today }
    let(:test_size) { 55 }
    let(:tasks_num_per_page) { ApplicationController::TASKS_NUM_PER_PAGE }
    before do
      # テスト用データの作成
      test_size.times do |n|
        name = "test_task_#{n}"
        start_date = rand(today..(today + 365))
        necessary_days = rand(1..50)
        priority = rand(0..2)
        progress = rand(0..2)

        Task.create(name:,
                    start_date:,
                    necessary_days:,
                    priority:,
                    progress:)
      end
      # タスク一覧ページを表示
      visit tasks_path
    end

    context 'indexページを開いたとき' do
      it 'ページネーションが適用されている' do
        # 最初のページに表示されている件数を見る
        expect(page.all('.task').size).to eq(tasks_num_per_page)

        # 最後のページに移動
        click_on 'Last'

        # 最後のページのタスクを正確に取得するにはsleepが必要
        sleep 3

        # 最後のページに表示されている件数を見る
        expect(page.all('.task').size).to eq(test_size % tasks_num_per_page)
      end
    end
  end
end
