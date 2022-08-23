require 'rails_helper'

describe 'Tasks', type: :system do
  include TaskHelper

  describe '1 #index' do

    let(:task_one) { FactoryBot.create(:task_not_started) }
    let(:task_two) { FactoryBot.create(:task_not_started) }

    context '1-1 タスク1件' do

      let!(:task_index_1) { task_one }

      it '1-1-1 タイトルが一致すること' do
        visit root_path
        expect(page).to have_content task_index_1.title
      end

      it '1-1-2 ラベルが一致すること' do
        visit root_path
        expect(page).to have_content task_index_1.label
      end

      it '1-1-3 作成ボタンを押下することでタスク作成画面へ遷移すること' do
        visit root_path
        click_on '作成'
        expect(page).to have_current_path new_task_path
      end

      it '1-1-4 詳細ボタンを押下することでタスク詳細画面へ遷移すること' do
        visit root_path
        click_on '詳細', match: :first
        expect(page).to have_current_path task_path(task_index_1)
      end

    end

    context '1-2 タスク複数件' do

      let!(:task_index_2_one) { task_one }
      let!(:task_index_2_two) { task_two }

      it '1-2-1 1件目 タイトルが一致すること' do
        visit root_path
        expect(page).to have_content task_index_2_one.title
      end

      it '1-2-2 1件目 ラベルが一致すること' do
        visit root_path
        expect(page).to have_content task_index_2_one.label
      end

      it '1-2-3 2件目 タイトルが一致すること' do
        visit root_path
        expect(page).to have_content task_index_2_two.title
      end

      it '1-2-4 2件目 ラベルが一致すること' do
        visit root_path
        expect(page).to have_content task_index_2_two.label
      end

      it '1-2-5 作成ボタンを押下することでタスク作成画面へ遷移すること' do
        visit root_path
        click_on '作成'
        expect(page).to have_current_path new_task_path
      end

      it '1-2-6 1件目 詳細ボタンを押下することでタスク詳細画面へ遷移すること' do
        visit root_path
        all('a', :text => '詳細')[0].click
        expect(page).to have_current_path task_path(task_index_2_two)
      end

      it '1-2-7 2件目 詳細ボタンを押下することでタスク詳細画面へ遷移すること' do
        visit root_path
        all('a', :text => '詳細')[1].click
        expect(page).to have_current_path task_path(task_index_2_one)
      end

    end

  end

  describe '2 #new' do

    context '2-1 全項目入力' do

      let(:new_task) {
        {
          title: '新規タスク 全項目入力 タイトル',
          content: '新規タスク 全項目入力 内容',
          label: '新規タスク 全項目入力 ラベル',
        }
      }

      it '2-1-1 登録内容が想定通りであること' do

        # 画面遷移
        visit new_task_path

        # 新規タスク登録
        fill_in 'task[title]', with: new_task[:title]
        fill_in 'task[content]', with: new_task[:content]
        fill_in 'task[label]', with: new_task[:label]
        # ボタン押下
        click_on '作成'

        # 項目比較
        expect(Task.find_by(title: new_task[:title], content: new_task[:content], label: new_task[:label])).not_to be_nil 

      end

    end

    context '2-2 タイトルのみ入力' do

      let(:new_task) {
        {
          title: '新規タスク タイトルのみ入力 タイトル',
          content: '',
          label: '',
        }
      }

      it '2-2-1 登録内容が想定通りであること' do

        # 画面遷移
        visit new_task_path

        # 新規タスク登録
        fill_in 'task[title]', with: new_task[:title]
        fill_in 'task[content]', with: new_task[:content]
        fill_in 'task[label]', with: new_task[:label]
        # ボタン押下
        click_on '作成'

        # 項目比較
        expect(Task.find_by(title: new_task[:title], content: new_task[:content], label: new_task[:label])).not_to be_nil 

      end

    end

    context '2-3 内容のみ入力' do
      let(:new_task) {
        {
          title: '',
          content: '新規タスク 内容のみ入力 内容',
          label: '',
        }
      }

      it '2-3-1 登録内容が想定通りであること' do

        # 画面遷移
        visit new_task_path

        # 新規タスク登録
        fill_in 'task[title]', with: new_task[:title]
        fill_in 'task[content]', with: new_task[:content]
        fill_in 'task[label]', with: new_task[:label]
        # ボタン押下
        click_on '作成'

        # 項目比較
        expect(Task.find_by(title: new_task[:title], content: new_task[:content], label: new_task[:label])).not_to be_nil 

      end

    end

    context '2-4 ラベルのみ入力' do

      let(:new_task) {
        {
          title: '',
          content: '',
          label: '新規タスク ラベルのみ入力 ラベル',
        }
      }

      it '2-4-1 登録内容が想定通りであること' do

        # 画面遷移
        visit new_task_path

        # 新規タスク登録
        fill_in 'task[title]', with: new_task[:title]
        fill_in 'task[content]', with: new_task[:content]
        fill_in 'task[label]', with: new_task[:label]
        # ボタン押下
        click_on '作成'

        # 項目比較
        expect(Task.find_by(title: new_task[:title], content: new_task[:content], label: new_task[:label])).not_to be_nil 

      end

    end

    context '2-5 画面遷移' do

      let(:new_task) {
        {
          title: '新規タスク 全項目入力 タイトル',
          content: '新規タスク 全項目入力 内容',
          label: '新規タスク 全項目入力 ラベル',
        }
      }

      it '2-5-1 一覧へボタン押下でタスク一覧画面へ遷移すること' do
        visit new_task_path
        click_on '一覧へ'
        expect(page).to have_current_path root_path
      end

      it '2-5-2 作成ボタン押下でタスク一覧画面へ遷移すること' do
        visit new_task_path
        # 新規タスク登録
        fill_in 'task[title]', with: new_task[:title]
        fill_in 'task[content]', with: new_task[:content]
        fill_in 'task[label]', with: new_task[:label]
        # ボタン押下
        click_on '作成'
        expect(page).to have_current_path root_path
      end

      it '2-5-3 作成後メッセージが表示されること' do
        visit new_task_path
        # 新規タスク登録
        fill_in 'task[title]', with: new_task[:title]
        fill_in 'task[content]', with: new_task[:content]
        fill_in 'task[label]', with: new_task[:label]
        # ボタン押下
        click_on '作成'
        expect(page).to have_content 'タスク作成成功'
      end

    end

  end

  describe '3 #show' do

    let(:task_one) { FactoryBot.create(:task_not_started) }

    context '3-1 タスク1件' do

      it '3-1-1 タイトルが一致すること' do
        visit task_path(task_one)
        expect(page).to have_content task_one.title
      end

      it '3-1-2 ラベルが一致すること' do
        visit task_path(task_one)
        expect(page).to have_content task_one.label
      end

      it '3-1-3 内容が一致すること' do
        visit task_path(task_one)
        expect(page).to have_content task_one.content
      end

      it '3-1-4 編集ボタン押下で編集画面へ遷移すること' do
        visit task_path(task_one)
        click_on '編集'
        expect(page).to have_current_path edit_task_path(task_one)
      end

      it '3-1-5 削除ボタン押下で項目が削除されること' do
        visit task_path(task_one)
        click_on '削除'
        expect(Task.find_by(id: task_one.id)).to be_nil
      end

      it '3-1-6 一覧へボタン押下でタスク一覧画面へ遷移すること' do
        visit task_path(task_one)
        click_on '一覧へ'
        expect(page).to have_current_path root_path
      end

    end

    context '3-2 画面遷移' do

      let(:task_one) { FactoryBot.create(:task_not_started) }

      it '3-2-1 削除ボタン押下でタスク一覧画面へ遷移すること' do
        visit task_path(task_one)
        click_on '削除'
        expect(page).to have_current_path root_path
      end

      it '3-2-2 削除後メッセージが表示されること' do
        visit task_path(task_one)
        click_on '削除'
        expect(page).to have_content 'タスク削除成功'
      end

    end

  end

  describe '4 #edit' do

    context '4-1 初期表示' do

      let(:task_one) { FactoryBot.create(:task_not_started) }

      it '4-1-1 タイトルが表示されていること' do

        visit edit_task_path(task_one)
        expect(page).to have_field 'task[title]', with: task_one.title

      end

      it '4-1-2 内容が表示されていること' do

        visit edit_task_path(task_one)
        expect(page).to have_field 'task[content]', with: task_one.content

      end

      it '4-1-3 ラベルが表示されていること' do

        visit edit_task_path(task_one)
        expect(page).to have_field 'task[label]', with: task_one.label

      end

    end

    context '4-2 全項目変更' do

      let(:task_one) { FactoryBot.create(:task_not_started) }

      let(:update_task) {
        {
          title: '全項目変更 タイトル',
          content: '全項目変更 内容',
          label: '全項目変更 ラベル',
        }
      }

      it '4-2-1 更新されていること' do

        visit edit_task_path(task_one)
        fill_in 'task[title]', with: update_task[:title]
        fill_in 'task[content]', with: update_task[:content]
        fill_in 'task[label]', with: update_task[:label]
        click_on '更新'
        expect(Task.find_by(title: update_task[:title], content: update_task[:content], label: update_task[:label])).not_to be_nil

      end

    end

    context '4-3 タイトルのみ変更' do

      let(:task_one) { FactoryBot.create(:task_not_started) }

      let(:update_task) {
        {
          title: '全項目変更 タイトル',
          content: 'こちらはテスト1の内容です。テストテストテストテストテストテストテスト',
          label: 'テスト',
        }
      }

      it '4-3-1 更新されていること' do

        visit edit_task_path(task_one)
        fill_in 'task[title]', with: update_task[:title]
        fill_in 'task[content]', with: update_task[:content]
        fill_in 'task[label]', with: update_task[:label]
        click_on '更新'
        expect(Task.find_by(title: update_task[:title], content: update_task[:content], label: update_task[:label])).not_to be_nil

      end

    end

    context '4-4 内容のみ変更' do

      let(:task_one) { FactoryBot.create(:task_not_started) }

      let(:update_task) {
        {
          title: 'テスト1',
          content: '全項目変更 内容',
          label: 'テスト',
        }
      }

      it '4-4-1 更新されていること' do

        visit edit_task_path(task_one)
        fill_in 'task[title]', with: update_task[:title]
        fill_in 'task[content]', with: update_task[:content]
        fill_in 'task[label]', with: update_task[:label]
        click_on '更新'
        expect(Task.find_by(title: update_task[:title], content: update_task[:content], label: update_task[:label])).not_to be_nil

      end

    end

    context '4-5 ラベルのみ変更' do

      let(:task_one) { FactoryBot.create(:task_not_started) }

      let(:update_task) {
        {
          title: 'テスト1',
          content: 'こちらはテスト1の内容です。テストテストテストテストテストテストテスト',
          label: '全項目変更 ラベル',
        }
      }

      it '4-5-1 更新されていること' do

        visit edit_task_path(task_one)
        fill_in 'task[title]', with: update_task[:title]
        fill_in 'task[content]', with: update_task[:content]
        fill_in 'task[label]', with: update_task[:label]
        click_on '更新'
        expect(Task.find_by(title: update_task[:title], content: update_task[:content], label: update_task[:label])).not_to be_nil

      end

    end

    # context '4-6 ステータスのみ変更' do

    #   let(:task_one) { FactoryBot.create(:task_not_started) }

    #   let(:update_task) {
    #     {
    #       title: 'テスト1',
    #       content: 'こちらはテスト1の内容です。テストテストテストテストテストテストテスト',
    #       label: 'テスト',
    #     }
    #   }

    #   it '4-6-1 更新されていること' do

    #     visit edit_task_path(task_one)
    #     fill_in 'task[title]', with: update_task[:title]
    #     fill_in 'task[content]', with: update_task[:content]
    #     fill_in 'task[label]', with: update_task[:label]
    #     click_on '更新'
    #     expect(Task.find_by(title: update_task[:title], content: update_task[:content], label: update_task[:label])).not_to be_nil

    #   end

    # end

    # context '4-7 ユーザのみ変更' do

    #   let(:task_one) { FactoryBot.create(:task_not_started) }

    #   let(:update_task) {
    #     {
    #       title: 'テスト1',
    #       content: 'こちらはテスト1の内容です。テストテストテストテストテストテストテスト',
    #       label: 'テスト',
    #     }
    #   }
     
    #   it '4-7-1 更新されていること' do

    #     visit edit_task_path(task_one)
    #     fill_in 'task[title]', with: update_task[:title]
    #     fill_in 'task[content]', with: update_task[:content]
    #     fill_in 'task[label]', with: update_task[:label]
    #     click_on '更新'
    #     expect(Task.find_by(title: update_task[:title], content: update_task[:content], label: update_task[:label])).not_to be_nil

    #   end

    # end

    context '4-8 画面遷移' do

      let(:task_one) { FactoryBot.create(:task_not_started) }

      let(:update_task) {
        {
          title: '全項目変更 タイトル',
          content: '全項目変更 内容',
          label: '全項目変更 ラベル',
        }
      }

      it '4-8-1 一覧へボタン押下でタスク一覧画面へ遷移すること' do

        visit edit_task_path(task_one)
        click_on '一覧へ'
        expect(page).to have_current_path root_path

      end

      it '4-8-2 更新ボタン押下でタスク一覧画面へ遷移すること' do
        visit edit_task_path(task_one)
        fill_in 'task[title]', with: update_task[:title]
        fill_in 'task[content]', with: update_task[:content]
        fill_in 'task[label]', with: update_task[:label]
        click_on '更新'
        expect(page).to have_current_path root_path
      end

      it '4-8-3 削除後メッセージが表示されること' do
        visit edit_task_path(task_one)
        fill_in 'task[title]', with: update_task[:title]
        fill_in 'task[content]', with: update_task[:content]
        fill_in 'task[label]', with: update_task[:label]
        click_on '更新'
        expect(page).to have_content 'タスク更新成功'
      end

    end

  end

end
