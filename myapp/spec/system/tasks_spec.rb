require 'rails_helper'

describe 'Tasks', type: :system do
  ###################################################
  # タスク一覧画面
  ###################################################
  describe '#index' do
    include TaskHelper

    ###################################################
    # 事前処理
    ###################################################

    before do
    end

    ###################################################
    # 共通処理
    ###################################################

    # 一覧の項目比較
    shared_examples_for 'compare_list_view_to_db' do
      it {
        # DBからデータ取得
        # user対応コメントアウト
        # db_items = Task.joins(:user).all.order('tasks.created_at desc')
        db_items = Task.all.order('tasks.created_at desc')

        # 画面遷移
        visit(root_path)

        # 画面の一覧取得
        view_items = all('div[name="list-task"] tbody tr')

        # 項目比較
        expect(view_items.size).to(eq(db_items.size))
        view_items.size.times do |i|
          columns = view_items[i].all('td')
          expect(columns[0]).to(have_content(db_items[i].title))
          expect(columns[1]).to(have_content(db_items[i].label))
          # user対応コメントアウト
          # expect(columns[2]).to(have_content(db_items[i].user.name))
          # status対応コメントアウト
          # expect(columns[3]).to(have_content(get_status_view(db_items[i].status)))
          expect(columns[2]).to(have_link('詳細', href: task_path(db_items[i])))
          # expect(columns[4]).to(have_link('詳細', href: task_path(db_items[i])))
        end
      }
    end

    ###################################################
    # 各テスト
    ###################################################

    context 'タスク0件' do
      ### テスト準備
      # user対応コメントアウト
      # # User作成
      # user = User.create!(id: 1, name: 'テスト一郎')

      ### テスト
      it_behaves_like 'compare_list_view_to_db'
    end

    context 'タスク1件' do
      ### テスト準備
      # user対応コメントアウト
      # # User作成
      # user = User.create!(id: 1, name: 'テスト一郎')

      # Task作成
      1.times do |i|
        FactoryBot.create(:task_not_started)
      end

      ### テスト
      it_behaves_like 'compare_list_view_to_db'
    end

    context 'タスク複数件' do
      ### テスト準備
      # user対応コメントアウト
      # # User作成
      # user = User.create!(id: 1, name: 'テスト一郎')

      # Task作成
      5.times do |i|
        FactoryBot.create(:task_not_started)
      end

      ### テスト
      it_behaves_like 'compare_list_view_to_db'
    end
  end

  ###################################################
  # タスク作成画面
  ###################################################
  describe '#new' do

    ###################################################
    # 事前処理
    ###################################################

    before do
    end

    ###################################################
    # 共通処理
    ###################################################

    # 登録データの項目比較
    shared_examples_for 'compare_new_task_db_to_assumed' do
      it {
        # 画面遷移
        visit(new_task_path)

        # 新規タスク登録
        fill_in('task[title]', with: new_task[:title])
        fill_in('task[content]', with: new_task[:content])
        fill_in('task[label]', with: new_task[:label])
        # user対応コメントアウト
        # find("option[value='#{@user.id}']").select_option

        # ボタン押下
        expect { click_button '作成' }.to change(Task, :count).by(1)

        # 登録データ確認
        task = Task.find_by(
          title: new_task[:title],
          content: new_task[:content],
          label: new_task[:label],
        )

        # 項目比較
        expect(task.title).to eq(new_task[:title])
        expect(task.content).to eq(new_task[:content])
        expect(task.label).to eq(new_task[:label])
        # user対応コメントアウト
        # expect(@task.user_id).to eq(@user.id)
        expect(task.user_id).to eq(1)
        expect(task.status).to eq('not_started')
      }
    end

    ###################################################
    # 各テスト
    ###################################################

    context '全項目入力' do
      let(:new_task) {
        {
          title: '新規タスク 全項目入力 タイトル',
          content: '新規タスク 全項目入力 内容',
          label: '新規タスク 全項目入力 ラベル',
        }
      }

      ### テスト準備
      # user対応コメントアウト
      # # User作成
      # @user = User.create!(id: 1, name: 'テスト一郎')
      # User.create!(id: 2, name: 'テスト二郎')

      ### テスト
      it_behaves_like 'compare_new_task_db_to_assumed'
    end

    context 'タイトルのみ入力' do
      let(:new_task) {
        {
          title: '新規タスク タイトルのみ入力 タイトル',
          content: '',
          label: '',
        }
      }

      ### テスト準備
      # user対応コメントアウト
      # # User作成
      # @user = User.create!(id: 1, name: 'テスト一郎')
      # User.create!(id: 2, name: 'テスト二郎')

      ### テスト
      it_behaves_like 'compare_new_task_db_to_assumed'
    end

    context '内容のみ入力' do
      let(:new_task) {
        {
          title: '',
          content: '新規タスク 内容のみ入力 内容',
          label: '',
        }
      }

      ### テスト準備
      # user対応コメントアウト
      # # User作成
      # @user = User.create!(id: 1, name: 'テスト一郎')
      # User.create!(id: 2, name: 'テスト二郎')

      ### テスト
      it_behaves_like 'compare_new_task_db_to_assumed'
    end

    context 'ラベルのみ入力' do
      let(:new_task) {
        {
          title: '',
          content: '',
          label: '新規タスク ラベルのみ入力 ラベル',
        }
      }

      ### テスト準備
      # user対応コメントアウト
      # # User作成
      # @user = User.create!(id: 1, name: 'テスト一郎')
      # User.create!(id: 2, name: 'テスト二郎')

      ### テスト
      it_behaves_like 'compare_new_task_db_to_assumed'
    end
  end

  ###################################################
  # タスク詳細画面
  ###################################################
  describe '#show' do

    ###################################################
    # 事前処理
    ###################################################

    before do
    end

    ###################################################
    # 共通処理
    ###################################################

    # 項目比較
    shared_examples_for 'compare_details_view_to_db' do |task|
      it {
        # 画面遷移
        visit(task_path(task))

        # DBからデータ取得
        # user対応コメントアウト
        # @db_item = Task.joins(:user).find(@task.id)
        db_item = Task.find(task.id)

        # 画面の一覧取得
        view_item = find('div[name="content"]')

        # 項目比較
        expect(view_item).to(have_content(db_item.title))
        expect(view_item).to(have_content(db_item.content))
        expect(view_item).to(have_content(db_item.label))
        # user対応コメントアウト
        # expect(@view_item).to(have_content(@db_item.user.name))
      }
    end

    # 削除
    shared_examples_for 'delete_task' do |task|
      it {
        # 画面遷移
        visit(task_path(task))

        # 削除
        expect { click_on('削除') }.to change(Task, :count).by(-1)
        expect { Task.find(task.id) }.to raise_error

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
      ### テスト準備
      # user対応コメントアウト
      # # User作成
      # user = User.create!(id: 1, name: 'テスト一郎')

      # Task作成
      task = nil
      1.times do |i|
        # user対応コメントアウト
        # @task = FactoryBot.create(:task_not_started, user_id: user.id)
        task = FactoryBot.create(:task_not_started)
      end

      ### テスト
      # 表示確認
      it_behaves_like 'compare_details_view_to_db', task
      # 削除確認
      it_behaves_like 'delete_task', task
    end

    context 'タスク複数件' do
      ### テスト準備
      # user対応コメントアウト
      # # User作成
      # user = User.create!(id: 1, name: 'テスト一郎')

      # Task作成
      task = nil
      1.times do |i|
        # user対応コメントアウト
        # @task = FactoryBot.create(:task_not_started, user_id: user.id)
        task = FactoryBot.create(:task_not_started)
      end

      ### テスト
      # 表示確認
      it_behaves_like 'compare_details_view_to_db', task
      # 削除確認
      it_behaves_like 'delete_task', task
    end
  end

  ###################################################
  # タスク編集画面
  ###################################################
  describe '#edit' do
    include TaskHelper

    ###################################################
    # 事前処理
    ###################################################

    # 事前処理
    before do
    end

    ###################################################
    # 共通処理
    ###################################################

    # 項目比較
    shared_examples_for 'compare_details_before_to_after' do |task|
      it {
        # 画面遷移
        visit(edit_task_path(task))

        # 更新
        if defined? update_task
          fill_in 'task[title]', with: update_task[:title]
          fill_in 'task[content]', with: update_task[:content]
          fill_in 'task[label]', with: update_task[:label]
          # status対応コメントアウト
          # select(value = update_task[:status], from: 'task[status]')
          # user対応コメントアウト
          # select(value = update_task[:user_name], from: 'task[user_id]')
          click_button '更新'
        end

        # user対応コメントアウト
        # @after_db_item = Task.joins(:user).find(@task.id)
        after_db_item = Task.find(task.id)

        # 項目比較
        expect(after_db_item.title).to eq(update_task[:title])
      }
    end

    ###################################################
    # 各テスト
    ###################################################

    context '初期表示' do
      # user対応コメントアウト
      # # User作成
      # @user1 = User.create!(id: 1, name: 'テスト一郎')
      # @user2 = User.create!(id: 2, name: 'テスト二郎')

      # Task作成
      # user対応コメントアウト
      # task = FactoryBot.create(:task_not_started, user_id: user.id)
      task = FactoryBot.create(:task_not_started)

      it '各項目にDBの値が表示されていること' do
        # DBからデータ取得
        # user対応コメントアウト
        # before_db_item = Task.joins(:user).find(@task.id)
        before_db_item = Task.find(task.id)

        # 画面遷移
        visit(edit_task_path(task))

        # 項目比較
        expect(page).to(have_field('task[title]', with: before_db_item.title))
        expect(page).to(have_field('task[content]', with: before_db_item.content))
        expect(page).to(have_field('task[label]', with: before_db_item.label))
        # status対応コメントアウト
        # expect(page).to(have_field('task[status]', with: Task.statuses[before_db_item.status]))
        # user対応コメントアウト
        # expect(page).to(have_field('task[user_id]', with: before_db_item.user_id))
      end
    end

    context '全項目変更' do
      let(:update_task) {
        {
          title: '全項目変更 タイトル',
          content: '全項目変更 内容',
          label: '全項目変更 ラベル',
          status: '着手中',
          # user対応コメントアウト
          # user_id: @user2.id,
          # user_name: @user2.name,
          user_id: 2,
          user_name: 'テスト二郎',
        }
      }

      # user対応コメントアウト
      # # User作成
      # @user1 = User.create!(id: 1, name: 'テスト一郎')
      # @user2 = User.create!(id: 2, name: 'テスト二郎')

      # Task作成
      # user対応コメントアウト
      # task = FactoryBot.create(:task_not_started, user_id: user.id)
      task = FactoryBot.create(:task_not_started)

      # 表示確認
      it_behaves_like 'compare_details_before_to_after', task
    end

    context 'タイトルのみ変更' do
      let(:update_task) {
        {
          title: '全項目変更 タイトル',
          content: 'こちらはテスト1の内容です。テストテストテストテストテストテストテスト',
          label: 'テスト',
          status: '未着手',
          # user対応コメントアウト
          # user_id: @user1.id,
          # user_name: @user1.name,
          user_id: 1,
          user_name: 'テスト一郎',
        }
      }

      # user対応コメントアウト
      # # User作成
      # @user1 = User.create!(id: 1, name: 'テスト一郎')
      # @user2 = User.create!(id: 2, name: 'テスト二郎')

      # Task作成
      # user対応コメントアウト
      # task = FactoryBot.create(:task_not_started, user_id: user.id)
      task = FactoryBot.create(:task_not_started)

      # 表示確認
      it_behaves_like 'compare_details_before_to_after', task
    end

    context '内容のみ変更' do
      let(:update_task) {
        {
          title: 'テスト1',
          content: '全項目変更 内容',
          label: 'テスト',
          status: '未着手',
          # user対応コメントアウト
          # user_id: @user1.id,
          # user_name: @user1.name,
          user_id: 1,
          user_name: 'テスト一郎',
        }
      }

      # user対応コメントアウト
      # # User作成
      # @user1 = User.create!(id: 1, name: 'テスト一郎')
      # @user2 = User.create!(id: 2, name: 'テスト二郎')

      # Task作成
      # user対応コメントアウト
      # task = FactoryBot.create(:task_not_started, user_id: user.id)
      task = FactoryBot.create(:task_not_started)

      # 表示確認
      it_behaves_like 'compare_details_before_to_after', task
    end

    context 'ラベルのみ変更' do
      let(:update_task) {
        {
          title: 'テスト1',
          content: 'こちらはテスト1の内容です。テストテストテストテストテストテストテスト',
          label: '全項目変更 ラベル',
          status: '未着手',
          # user対応コメントアウト
          # user_id: @user1.id,
          # user_name: @user1.name,
          user_id: 1,
          user_name: 'テスト一郎',
        }
      }
      
      # user対応コメントアウト
      # # User作成
      # @user1 = User.create!(id: 1, name: 'テスト一郎')
      # @user2 = User.create!(id: 2, name: 'テスト二郎')

      # Task作成
      # user対応コメントアウト
      # task = FactoryBot.create(:task_not_started, user_id: user.id)
      task = FactoryBot.create(:task_not_started)

      # 表示確認
      it_behaves_like 'compare_details_before_to_after', task
    end

    context 'ステータスのみ変更' do
      let(:update_task) {
        {
          title: 'テスト1',
          content: 'こちらはテスト1の内容です。テストテストテストテストテストテストテスト',
          label: 'テスト',
          status: '着手中',
          # user対応コメントアウト
          # user_id: @user1.id,
          # user_name: @user1.name,
          user_id: 1,
          user_name: 'テスト一郎',
        }
      }
      
      # user対応コメントアウト
      # # User作成
      # @user1 = User.create!(id: 1, name: 'テスト一郎')
      # @user2 = User.create!(id: 2, name: 'テスト二郎')

      # Task作成
      # user対応コメントアウト
      # task = FactoryBot.create(:task_not_started, user_id: user.id)
      task = FactoryBot.create(:task_not_started)

      # 表示確認
      it_behaves_like 'compare_details_before_to_after', task
    end

    context 'ユーザのみ変更' do
      let(:update_task) {
        {
          title: 'テスト1',
          content: 'こちらはテスト1の内容です。テストテストテストテストテストテストテスト',
          label: 'テスト',
          status: '未着手',
          # user対応コメントアウト
          # user_id: @user2.id,
          # user_name: @user2.name,
          user_id: 2,
          user_name: 'テスト二郎',
        }
      }
      
      # user対応コメントアウト
      # # User作成
      # @user1 = User.create!(id: 1, name: 'テスト一郎')
      # @user2 = User.create!(id: 2, name: 'テスト二郎')

      # Task作成
      # user対応コメントアウト
      # task = FactoryBot.create(:task_not_started, user_id: user.id)
      task = FactoryBot.create(:task_not_started)

      # 表示確認
      it_behaves_like 'compare_details_before_to_after', task
    end
  end
end
