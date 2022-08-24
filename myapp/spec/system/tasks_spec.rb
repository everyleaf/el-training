require 'rails_helper'

describe 'Tasks', type: :system do
  include TaskHelper

  describe '#index' do

    describe '作成エリア' do

      it '作成ボタンを押下することでタスク作成画面へ遷移すること' do
        visit root_path
        click_on '作成'
        expect(page).to have_current_path new_task_path
      end

    end

    describe '一覧表示エリア' do

      context 'タスク1件' do

        let!(:task_one) { FactoryBot.create(:task) }

        it 'タイトルが一致すること' do
          visit root_path
          expect(page).to have_content task_one.title
        end

        it 'ラベルが一致すること' do
          visit root_path
          expect(page).to have_content task_one.label
        end

        it '詳細ボタンを押下することでタスク詳細画面へ遷移すること' do
          visit root_path
          click_on '詳細', match: :first
          expect(page).to have_current_path task_path(task_one)
        end

      end

      context 'タスク複数件' do

        let!(:task_one) { FactoryBot.create(:task) }
        let!(:task_two) { FactoryBot.create(:task, title: 'second title', content: 'second content', label: 'second label') }

        it '1件目 タイトルが一致すること' do
          visit root_path
          expect(page).to have_content task_one.title
        end

        it '1件目 ラベルが一致すること' do
          visit root_path
          expect(page).to have_content task_one.label
        end

        it '2件目 タイトルが一致すること' do
          visit root_path
          expect(page).to have_content task_two.title
        end

        it '2件目 ラベルが一致すること' do
          visit root_path
          expect(page).to have_content task_two.label
        end

        it '1件目 詳細ボタンを押下することでタスク詳細画面へ遷移すること' do
          visit root_path
          all('a', :text => '詳細')[0].click
          expect(page).to have_current_path task_path(task_two)
        end

        it '2件目 詳細ボタンを押下することでタスク詳細画面へ遷移すること' do
          visit root_path
          all('a', :text => '詳細')[1].click
          expect(page).to have_current_path task_path(task_one)
        end

      end

    end

  end

  describe '#new' do

    describe '入力エリア' do

      context '全項目入力' do

        let(:input_values) {
          {
            title: '新規タスク 全項目入力 タイトル',
            content: '新規タスク 全項目入力 内容',
            label: '新規タスク 全項目入力 ラベル',
          }
        }

        it '入力した値でTaskが作成されていること' do

          # 画面遷移
          visit new_task_path

          # 新規タスク登録
          fill_in 'task[title]', with: input_values[:title]
          fill_in 'task[content]', with: input_values[:content]
          fill_in 'task[label]', with: input_values[:label]
          # ボタン押下
          click_on '作成'

          # 項目比較
          expect(Task.find_by(input_values)).to be_present

        end

      end

      context 'タイトルのみ入力' do

        let(:input_values) {
          {
            title: '新規タスク タイトルのみ入力 タイトル',
            content: '',
            label: '',
          }
        }

        it '入力した値でTaskが作成されていること' do

          # 画面遷移
          visit new_task_path

          # 新規タスク登録
          fill_in 'task[title]', with: input_values[:title]
          fill_in 'task[content]', with: input_values[:content]
          fill_in 'task[label]', with: input_values[:label]
          # ボタン押下
          click_on '作成'

          # 項目比較
          expect(Task.find_by(input_values)).to be_present

        end

      end

      context '内容のみ入力' do

        let(:input_values) {
          {
            title: '',
            content: '新規タスク 内容のみ入力 内容',
            label: '',
          }
        }

        it '入力した値でTaskが作成されていること' do

          # 画面遷移
          visit new_task_path

          # 新規タスク登録
          fill_in 'task[title]', with: input_values[:title]
          fill_in 'task[content]', with: input_values[:content]
          fill_in 'task[label]', with: input_values[:label]
          # ボタン押下
          click_on '作成'

          # 項目比較
          expect(Task.find_by(input_values)).to be_present

        end

      end

      context 'ラベルのみ入力' do

        let(:input_values) {
          {
            title: '',
            content: '',
            label: '新規タスク ラベルのみ入力 ラベル',
          }
        }

        it '入力した値でTaskが作成されていること' do

          # 画面遷移
          visit new_task_path

          # 新規タスク登録
          fill_in 'task[title]', with: input_values[:title]
          fill_in 'task[content]', with: input_values[:content]
          fill_in 'task[label]', with: input_values[:label]
          # ボタン押下
          click_on '作成'

          # 項目比較
          expect(Task.find_by(input_values)).to be_present

        end

        it '作成ボタン押下でタスク一覧画面へ遷移すること' do
          visit new_task_path
          # 新規タスク登録
          fill_in 'task[title]', with: input_values[:title]
          fill_in 'task[content]', with: input_values[:content]
          fill_in 'task[label]', with: input_values[:label]
          # ボタン押下
          click_on '作成'
          expect(page).to have_current_path root_path
        end

        it '作成後メッセージが表示されること' do
          visit new_task_path
          # 新規タスク登録
          fill_in 'task[title]', with: input_values[:title]
          fill_in 'task[content]', with: input_values[:content]
          fill_in 'task[label]', with: input_values[:label]
          # ボタン押下
          click_on '作成'
          expect(page).to have_content 'タスク作成成功'
        end

      end

    end

    describe 'フッターエリア' do

      it '一覧へボタン押下でタスク一覧画面へ遷移すること' do
        visit new_task_path
        click_on '一覧へ'
        expect(page).to have_current_path root_path
      end

    end

  end

  describe '#show' do

    let(:task_one) { FactoryBot.create(:task) }

    describe '表示エリア' do

      it 'タイトルが一致すること' do
        visit task_path(task_one)
        expect(page).to have_content task_one.title
      end

      it 'ラベルが一致すること' do
        visit task_path(task_one)
        expect(page).to have_content task_one.label
      end

      it '内容が一致すること' do
        visit task_path(task_one)
        expect(page).to have_content task_one.content
      end

    end

    describe 'フッターエリア' do

      it '編集ボタン押下で編集画面へ遷移すること' do
        visit task_path(task_one)
        click_on '編集'
        expect(page).to have_current_path edit_task_path(task_one)
      end

      it '削除ボタン押下で項目が削除されること' do
        visit task_path(task_one)
        click_on '削除'
        expect(Task.find_by(id: task_one.id)).to be_nil
      end

      it '削除ボタン押下でタスク一覧画面へ遷移すること' do
        visit task_path(task_one)
        click_on '削除'
        expect(page).to have_current_path root_path
      end

      it '削除後メッセージが表示されること' do
        visit task_path(task_one)
        click_on '削除'
        expect(page).to have_content 'タスク削除成功'
      end

      it '一覧へボタン押下でタスク一覧画面へ遷移すること' do
        visit task_path(task_one)
        click_on '一覧へ'
        expect(page).to have_current_path root_path
      end

    end

  end

  describe '#edit' do

    let(:task_one) { FactoryBot.create(:task) }

    describe '入力エリア' do

      context '初期表示' do

        it 'タイトルが表示されていること' do

          visit edit_task_path(task_one)
          expect(page).to have_field 'task[title]', with: task_one.title

        end

        it '内容が表示されていること' do

          visit edit_task_path(task_one)
          expect(page).to have_field 'task[content]', with: task_one.content

        end

        it 'ラベルが表示されていること' do

          visit edit_task_path(task_one)
          expect(page).to have_field 'task[label]', with: task_one.label

        end

      end

      context '全項目変更' do

        let(:update_task) {
          {
            title: '全項目変更 タイトル',
            content: '全項目変更 内容',
            label: '全項目変更 ラベル',
          }
        }

        it '更新されていること' do

          visit edit_task_path(task_one)
          fill_in 'task[title]', with: update_task[:title]
          fill_in 'task[content]', with: update_task[:content]
          fill_in 'task[label]', with: update_task[:label]
          click_on '更新'
          expect(Task.find_by(update_task)).to be_present

        end

        it '更新ボタン押下でタスク一覧画面へ遷移すること' do
          visit edit_task_path(task_one)
          fill_in 'task[title]', with: update_task[:title]
          fill_in 'task[content]', with: update_task[:content]
          fill_in 'task[label]', with: update_task[:label]
          click_on '更新'
          expect(page).to have_current_path root_path
        end

        it '更新後メッセージが表示されること' do
          visit edit_task_path(task_one)
          fill_in 'task[title]', with: update_task[:title]
          fill_in 'task[content]', with: update_task[:content]
          fill_in 'task[label]', with: update_task[:label]
          click_on '更新'
          expect(page).to have_content 'タスク更新成功'
        end

      end

      context 'タイトルのみ変更' do

        let(:update_task) {
          {
            title: '全項目変更 タイトル',
            content: 'こちらはテスト1の内容です。テストテストテストテストテストテストテスト',
            label: 'テスト',
          }
        }

        it '更新されていること' do

          visit edit_task_path(task_one)
          fill_in 'task[title]', with: update_task[:title]
          fill_in 'task[content]', with: update_task[:content]
          fill_in 'task[label]', with: update_task[:label]
          click_on '更新'
          expect(Task.find_by(update_task)).to be_present

        end

      end

      context '内容のみ変更' do

        let(:update_task) {
          {
            title: 'テスト1',
            content: '全項目変更 内容',
            label: 'テスト',
          }
        }

        it '更新されていること' do

          visit edit_task_path(task_one)
          fill_in 'task[title]', with: update_task[:title]
          fill_in 'task[content]', with: update_task[:content]
          fill_in 'task[label]', with: update_task[:label]
          click_on '更新'
          expect(Task.find_by(update_task)).to be_present

        end

      end

      context 'ラベルのみ変更' do

        let(:update_task) {
          {
            title: 'テスト1',
            content: 'こちらはテスト1の内容です。テストテストテストテストテストテストテスト',
            label: '全項目変更 ラベル',
          }
        }

        it '更新されていること' do

          visit edit_task_path(task_one)
          fill_in 'task[title]', with: update_task[:title]
          fill_in 'task[content]', with: update_task[:content]
          fill_in 'task[label]', with: update_task[:label]
          click_on '更新'
          expect(Task.find_by(update_task)).to be_present

        end

      end

    end

    describe 'フッターエリア' do

      it '一覧へボタン押下でタスク一覧画面へ遷移すること' do

        visit edit_task_path(task_one)
        click_on '一覧へ'
        expect(page).to have_current_path root_path

      end

    end


    # context 'ステータスのみ変更' do

    #   let(:task_one) { FactoryBot.create(:task) }

    #   let(:update_task) {
    #     {
    #       title: 'テスト1',
    #       content: 'こちらはテスト1の内容です。テストテストテストテストテストテストテスト',
    #       label: 'テスト',
    #     }
    #   }

    #   it '更新されていること' do

    #     visit edit_task_path(task_one)
    #     fill_in 'task[title]', with: update_task[:title]
    #     fill_in 'task[content]', with: update_task[:content]
    #     fill_in 'task[label]', with: update_task[:label]
    #     click_on '更新'
    #     expect(Task.find_by(title: update_task[:title], content: update_task[:content], label: update_task[:label])).not_to be_nil

    #   end

    # end

    # context 'ユーザのみ変更' do

    #   let(:task_one) { FactoryBot.create(:task) }

    #   let(:update_task) {
    #     {
    #       title: 'テスト1',
    #       content: 'こちらはテスト1の内容です。テストテストテストテストテストテストテスト',
    #       label: 'テスト',
    #     }
    #   }

    #   it '更新されていること' do

    #     visit edit_task_path(task_one)
    #     fill_in 'task[title]', with: update_task[:title]
    #     fill_in 'task[content]', with: update_task[:content]
    #     fill_in 'task[label]', with: update_task[:label]
    #     click_on '更新'
    #     expect(Task.find_by(title: update_task[:title], content: update_task[:content], label: update_task[:label])).not_to be_nil

    #   end

    # end

  end

end
