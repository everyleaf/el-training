require 'rails_helper'

describe 'Tasks', type: :system do
  ###################################################
  # タスク一覧画面
  ###################################################
  describe '#index', type: :system do
    include TaskHelper

    ###################################################
    # 事前処理
    ###################################################

    before do
      # User作成
      user = User.create!(name: 'テスト一郎')

      # Task作成
      tasks_number.times do |i|
        Task.create!(
          title: "テスト#{i + 1}",
          content: "こちらはテスト#{i + 1}の内容です。テストテストテストテストテストテストテスト",
          user_id: user.id,
          status: '1',
          label: 'テスト',
        )
      end

      # 画面遷移
      visit('/')

      # DBからデータ取得
      # user対応コメントアウト
      # @db_items = Task.joins(:user).all.order('tasks.created_at desc')
      @db_items = Task.all.order('tasks.created_at desc')

      # 画面の一覧取得
      @view_items = all('div[name="list-task"] tbody tr')
    end

    ###################################################
    # 共通処理
    ###################################################

    # 一覧の項目比較
    shared_examples_for 'compare_list_view_to_db' do
      it {
        # 項目比較
        expect(@view_items.size).to(eq(@db_items.size))
        @view_items.size.times do |i|
          columns = @view_items[i].all('td')
          expect(columns[0]).to(have_content(@db_items[i].title))
          expect(columns[1]).to(have_content(@db_items[i].label))
          # user対応コメントアウト
          # expect(columns[2]).to(have_content(@db_items[i].user.name))
          # status対応コメントアウト
          # expect(columns[3]).to(have_content(get_status_view(@db_items[i].status)))
          expect(columns[2]).to(have_link('詳細', href: task_path(@db_items[i])))
          # expect(columns[4]).to(have_link('詳細', href: task_path(@db_items[i])))
        end
      }
    end

    ###################################################
    # 各テスト
    ###################################################

    context 'タスク0件' do
      let!(:tasks_number) { 0 }

      it_behaves_like 'compare_list_view_to_db'
    end

    context 'タスク1件' do
      let!(:tasks_number) { 1 }

      it_behaves_like 'compare_list_view_to_db'
    end

    context 'タスク複数件' do
      let!(:tasks_number) { 5 }

      it_behaves_like 'compare_list_view_to_db'
    end
  end

  ###################################################
  # タスク作成画面
  ###################################################
  describe '#new', type: :system do

    ###################################################
    # 事前処理
    ###################################################

    before do
      # User作成
      @user = User.create!(name: 'テスト一郎')
      User.create!(name: 'テスト二郎')

      # 画面遷移
      visit(new_task_path())

      # 新規タスク登録
      fill_in('task[title]', with: new_task[:title])
      fill_in('task[content]', with: new_task[:content])
      fill_in('task[label]', with: new_task[:label])
      find("option[value='#{@user.id}']").select_option

      # タスク登録確認
      expect { click_button '作成' }.to change(Task, :count).by(1)

      # 登録データ確認
      @task = Task.find_by(
        title: new_task[:title],
        content: new_task[:content],
        label: new_task[:label],
      )
    end

    ###################################################
    # 共通処理
    ###################################################

    # 登録データの項目比較
    shared_examples_for 'compare_new_task_db_to_assumed' do
      it {
        # 項目比較
        expect(@task.title).to eq(new_task[:title])
        expect(@task.content).to eq(new_task[:content])
        expect(@task.label).to eq(new_task[:label])
        expect(@task.user_id).to eq(@user.id)
        expect(@task.status).to eq('not_started')
      }
    end

    ###################################################
    # 各テスト
    ###################################################

    context '全項目入力' do
      let!(:new_task) {
        {
          title: '新規タスク 全項目入力 タイトル',
          content: '新規タスク 全項目入力 内容',
          label: '新規タスク 全項目入力 ラベル',
        }
      }

      it_behaves_like 'compare_new_task_db_to_assumed'
    end

    context 'タイトルのみ入力' do
      let!(:new_task) {
        {
          title: '新規タスク タイトルのみ入力 タイトル',
          content: '',
          label: '',
        }
      }

      it_behaves_like 'compare_new_task_db_to_assumed'
    end

    context '内容のみ入力' do
      let!(:new_task) {
        {
          title: '',
          content: '新規タスク 内容のみ入力 内容',
          label: '',
        }
      }

      it_behaves_like 'compare_new_task_db_to_assumed'
    end

    context 'ラベルのみ入力' do
      let!(:new_task) {
        {
          title: '',
          content: '',
          label: '新規タスク ラベルのみ入力 ラベル',
        }
      }

      it_behaves_like 'compare_new_task_db_to_assumed'
    end
  end

  ###################################################
  # タスク詳細画面
  ###################################################
  describe '#show', type: :system do
    ###################################################
    # 事前処理
    ###################################################

    before do
      # User作成
      user = User.create!(name: 'テスト一郎')

      # Task作成
      @task = nil
      tasks_number.times do |i|
        @task = Task.create!(
          title: "テスト#{i + 1}",
          content: "こちらはテスト#{i + 1}の内容です。テストテストテストテストテストテストテスト",
          user_id: user.id,
          status: '1',
          label: 'テスト',
        )
      end

      # 画面遷移
      visit(task_path(@task))

      # DBからデータ取得
      # user対応コメントアウト
      # @db_item = Task.joins(:user).find(params[:id])
      @db_item = Task.find(params[:id])

      # 画面の一覧取得
      @view_item = find('div[name="content"]')
    end

    ###################################################
    # 共通処理
    ###################################################

    # 項目比較
    shared_examples_for 'compare_details_view_to_db' do
      it {
        # 項目比較
        expect(@view_item).to(have_content(@db_item.title))
        expect(@view_item).to(have_content(@db_item.content))
        expect(@view_item).to(have_content(@db_item.label))
        # user対応コメントアウト
        # expect(@view_item).to(have_content(@db_item.user.name))
      }
    end

    # 削除
    shared_examples_for 'delete_task' do
      it {
        # 画面遷移
        visit(task_path(@task))

        # 削除
        expect { click_on('削除') }.to change(Task, :count).by(-1)
        expect(
          Task.find_by(
            title: @task.title,
            content: @task.content,
            label: @task.label,
            user_id: @task.user_id,
          ),
        ).to be_nil

        ## 以下、confirm対応バージョン
        ## 現在はエラーが発生するためコメントアウト
        # click_link '削除'
        # expect {
        #     page.accept_confirm '削除しますか？'
        #     expect(page).to have_content '削除しました'
        # }.to change { Task.count }.by(-1)
      }
    end

    ###################################################
    # 各テスト
    ###################################################

    context 'タスク1件' do
      let!(:tasks_number) { 1 }
      # 表示確認

      it_behaves_like 'compare_details_view_to_db'
      # 削除確認
      it_behaves_like 'delete_task'
    end

    context 'タスク複数件' do
      let!(:tasks_number) { 5 }
      # 表示確認

      it_behaves_like 'compare_details_view_to_db'
      # 削除確認
      it_behaves_like 'delete_task'
    end
  end

  ###################################################
  # タスク編集画面
  ###################################################
  describe '#edit', type: :system do
    include TaskHelper

    ###################################################
    # 事前処理
    ###################################################

    # 事前処理
    before do
      # User作成
      @user1 = User.create!(name: 'テスト一郎')
      @user2 = User.create!(name: 'テスト二郎')

      # Task作成
      @task = Task.create!(
        title: 'テスト1',
        content: 'こちらはテスト1の内容です。テストテストテストテストテストテストテスト',
        user_id: @user1.id,
        status: '1',
        label: 'テスト',
      )

      # 画面遷移
      visit(edit_task_path(@task))

      # DBからデータ取得
      # user対応コメントアウト
      # @before_db_item = Task.joins(:user).find(params[:id])
      @before_db_item = Task.find(params[:id])

      # 更新
      if defined? update_task
        fill_in 'task[title]', with: update_task[:title]
        fill_in 'task[content]', with: update_task[:content]
        fill_in 'task[label]', with: update_task[:label]
        select(value = update_task[:status], from: 'task[status]')
        select(value = update_task[:user_name], from: 'task[user_id]')
        click_button '更新'
      end

      # user対応コメントアウト
      # @after_db_item = Task.joins(:user).find(params[:id])
      @after_db_item = Task.find(params[:id])
    end

    ###################################################
    # 共通処理
    ###################################################

    # 項目比較
    shared_examples_for 'compare_details_before_to_after' do
      it {
        # 項目比較
        expect(@after_db_item.title).to eq(update_task[:title])
      }
    end

    ###################################################
    # 各テスト
    ###################################################

    context '初期表示' do
      it '各項目にDBの値が表示されていること' do
        # 画面遷移
        visit(edit_task_path(@task))

        # 項目比較
        expect(page).to(have_field('task[title]', with: @before_db_item.title))
        expect(page).to(have_field('task[content]', with: @before_db_item.content))
        expect(page).to(have_field('task[label]', with: @before_db_item.label))
        expect(page).to(have_field('task[status]', with: Task.statuses[@before_db_item.status]))
        expect(page).to(have_field('task[user_id]', with: @before_db_item.user_id))
      end
    end

    context '全項目変更' do
      let!(:update_task) {
        {
          title: '全項目変更 タイトル',
          content: '全項目変更 内容',
          label: '全項目変更 ラベル',
          status: '着手中',
          user_id: @user2.id,
          user_name: @user2.name,
        }
      }

      # 表示確認
      it_behaves_like 'compare_details_before_to_after'
    end

    context 'タイトルのみ変更' do
      let!(:update_task) {
        {
          title: '全項目変更 タイトル',
          content: 'こちらはテスト1の内容です。テストテストテストテストテストテストテスト',
          label: 'テスト',
          status: '未着手',
          user_id: @user1.id,
          user_name: @user1.name,
        }
      }

      # 表示確認
      it_behaves_like 'compare_details_before_to_after'
    end

    context '内容のみ変更' do
      let!(:update_task) {
        {
          title: 'テスト1',
          content: '全項目変更 内容',
          label: 'テスト',
          status: '未着手',
          user_id: @user1.id,
          user_name: @user1.name,
        }
      }

      # 表示確認
      it_behaves_like 'compare_details_before_to_after'
    end

    context 'ラベルのみ変更' do
      let!(:update_task) {
        {
          title: 'テスト1',
          content: 'こちらはテスト1の内容です。テストテストテストテストテストテストテスト',
          label: '全項目変更 ラベル',
          status: '未着手',
          user_id: @user1.id,
          user_name: @user1.name,
        }
      }

      # 表示確認
      it_behaves_like 'compare_details_before_to_after'
    end

    context 'ステータスのみ変更' do
      let!(:update_task) {
        {
          title: 'テスト1',
          content: 'こちらはテスト1の内容です。テストテストテストテストテストテストテスト',
          label: 'テスト',
          status: '着手中',
          user_id: @user1.id,
          user_name: @user1.name,
        }
      }

      # 表示確認
      it_behaves_like 'compare_details_before_to_after'
    end

    context 'ユーザのみ変更' do
      let!(:update_task) {
        {
          title: 'テスト1',
          content: 'こちらはテスト1の内容です。テストテストテストテストテストテストテスト',
          label: 'テスト',
          status: '未着手',
          user_id: @user2.id,
          user_name: @user2.name,
        }
      }

      # 表示確認
      it_behaves_like 'compare_details_before_to_after'
    end
  end
end
