# frozen_string_literal: true

require 'rails_helper'
require 'pp'

RSpec.describe 'Tasks', type: :system do
  let!(:login_user) { FactoryBot.create(:user, name: '夏目', email: 'natsume@example.com') }
  let!(:other_user) { FactoryBot.create(:user, name: 'ニャンコ先生', email: 'nyanko@example.com') }
  subject { page }

  before 'ログイン' do
    visit login_path
    fill_in 'email', with: login_user.email
    fill_in 'password', with: login_user.password
    click_button 'ログイン'
  end

  describe 'アクセス権' do
    let!(:task) { FactoryBot.create(:task, user: login_user) }

    context 'ログイン状態の時' do
      it '#indexにアクセスできること' do
        visit root_path
        expect(current_path).to eq(root_path)
      end
      it '#show(task_id)にアクセスできること' do
        visit task_path task.id
        expect(current_path).to eq(task_path(task.id))
      end
      it '#edit(task_id)にアクセスできること' do
        visit edit_task_path task.id
        expect(current_path).to eq(edit_task_path(task.id))
      end
      it '#newにアクセスできること' do
        visit new_task_path
        expect(current_path).to eq(new_task_path)
      end
    end

    context '未ログイン状態の時' do
      before 'ログアウト' do
        click_link nil, href: logout_path
      end
      it '#indexにアクセスできないこと' do
        visit root_path
        expect(current_path).to eq(login_path)
      end
      it '#show(task_id)にアクセスできないこと' do
        visit task_path task.id
        expect(current_path).to eq(login_path)
      end
      it '#edit(task_id)にアクセスできないこと' do
        visit edit_task_path task.id
        expect(current_path).to eq(login_path)
      end
      it '#newにアクセスできないこと' do
        visit new_task_path
        expect(current_path).to eq(login_path)
      end
    end
  end

  describe '#index' do
    shared_examples '期待した順番で表示されること' do
      it do
        task_list = all('tbody tr')
        expected_list.each_with_index do |task, i|
          expect(task_list[i].first('td').text).to eq task.title
        end
      end
    end

    shared_examples '期待しないタスクが表示されないこと' do
      it do
        unexpected_list.each_with_index do |task, _|
          is_expected.to_not have_content task.title
        end
      end
    end

    describe '表示項目' do
      let!(:task) { FactoryBot.create(:task, title: '七辻屋に行く', detail: '大福', end_date: Time.zone.today + 1.weeks, user: login_user) }
      it '期待した項目が表示されること' do
        visit root_path
        is_expected.to have_content task.title
        is_expected.to have_content task.detail
        is_expected.to have_content task.end_date.strftime('%Y/%m/%d')
      end
    end

    describe 'ログイン機能' do
      let!(:task1) { FactoryBot.create(:task, user: login_user) }
      let!(:task2) { FactoryBot.create(:task, user: other_user) }
      it 'ログインユーザのタスクのみが表示されること' do
        visit root_path
        is_expected.to have_content task1.title
        is_expected.to_not have_content task2.title
      end
    end

    describe 'ソート機能' do
      describe 'タスク名' do
        let!(:task1) { FactoryBot.create(:task, title: 'う　買い物に行く', user: login_user) }
        let!(:task2) { FactoryBot.create(:task, title: 'あ　料理をする', user: login_user) }
        let!(:task3) { FactoryBot.create(:task, title: 'い　食べる', user: login_user) }
        let!(:task4) { FactoryBot.create(:task, title: 'え　洗濯する', user: login_user) }
        context '昇順' do
          before do
            visit root_path
            click_link nil, id: 'title_asc'
          end
          let(:expected_list) { [task2, task3, task1, task4] }
          it_behaves_like '期待した順番で表示されること'
        end
        context '降順' do
          before do
            visit root_path
            click_link nil, id: 'title_desc'
          end
          let(:expected_list) { [task4, task1, task3, task2] }
          it_behaves_like '期待した順番で表示されること'
        end
      end
      describe '作成日時' do
        let!(:task1) { FactoryBot.create(:task, created_at: Time.current + 1.days, user: login_user) }
        let!(:task2) { FactoryBot.create(:task, created_at: Time.current + 2.days, user: login_user) }
        let!(:task3) { FactoryBot.create(:task, created_at: Time.current + 3.days, user: login_user) }
        let!(:task4) { FactoryBot.create(:task, created_at: Time.current + 4.days, user: login_user) }
        context '昇順' do
          before do
            visit root_path
            click_link nil, id: 'created_at_asc'
          end
          let(:expected_list) { [task1, task2, task3, task4] }
          it_behaves_like '期待した順番で表示されること'
        end
        context '降順' do
          before do
            visit root_path
            click_link nil, id: 'created_at_desc'
          end
          let(:expected_list) { [task4, task3, task2, task1] }
          it_behaves_like '期待した順番で表示されること'
        end
      end
      describe '終了期限' do
        let!(:task1) { FactoryBot.create(:task, end_date: Time.zone.today + 2.weeks, user: login_user) }
        let!(:task2) { FactoryBot.create(:task, end_date: Time.zone.today + 1.week, user: login_user) }
        let!(:task3) { FactoryBot.create(:task, end_date: Time.zone.today + 3.weeks, user: login_user) }
        let!(:task4) { FactoryBot.create(:task, end_date: Time.zone.today + 4.weeks, user: login_user) }
        context '昇順' do
          before do
            visit root_path
            click_link nil, id: 'end_date_asc'
          end
          let(:expected_list) { [task2, task1, task3, task4] }
          it_behaves_like '期待した順番で表示されること'
        end
        context '降順' do
          before do
            visit root_path
            click_link nil, id: 'end_date_desc'
          end
          let(:expected_list) { [task4, task3, task1, task2] }
          it_behaves_like '期待した順番で表示されること'
        end
      end
      describe 'ステータス' do
        let!(:task1) { FactoryBot.create(:task, status: 'done', user: login_user) }
        let!(:task2) { FactoryBot.create(:task, status: 'doing', user: login_user) }
        let!(:task3) { FactoryBot.create(:task, status: 'todo', user: login_user) }
        let!(:task4) { FactoryBot.create(:task, status: 'done', user: login_user) }
        context '昇順' do
          before do
            visit root_path
            click_link nil, id: 'status_asc'
          end
          let(:expected_list) { [task3, task2, task4, task1] }
          it_behaves_like '期待した順番で表示されること'
        end
        context '降順' do
          before do
            visit root_path
            click_link nil, id: 'status_desc'
          end
          let(:expected_list) { [task4, task1, task2, task3] }
          it_behaves_like '期待した順番で表示されること'
        end
      end
    end

    describe '検索機能' do
      let!(:task1) { FactoryBot.create(:task, title: 'う　買い物に行く', status: 'done', user: login_user) }
      let!(:task2) { FactoryBot.create(:task, title: 'あ　料理をする', status: 'doing', user: login_user) }
      let!(:task3) { FactoryBot.create(:task, title: 'い　食べる', status: 'todo', user: login_user) }
      let!(:task4) { FactoryBot.create(:task, title: 'え　洗濯する', status: 'done', user: login_user) }

      context 'タスク名を指定' do
        before do
          visit root_path
          fill_in 'title', with: '料理'
          click_button '検索'
        end
        let(:expected_list) { [task2] }
        it_behaves_like '期待した順番で表示されること'
        let(:unexpected_list) { [task1, task3, task4] }
        it_behaves_like '期待しないタスクが表示されないこと'
      end
      context 'ステータスを指定' do
        before do
          visit root_path
          select '完了', from: 'status'
          click_button '検索'
        end
        let(:expected_list) { [task4, task1] }
        it_behaves_like '期待した順番で表示されること'
        let(:unexpected_list) { [task2, task3] }
        it_behaves_like '期待しないタスクが表示されないこと'
      end
      context 'タスク名とステータスを指定' do
        before do
          visit root_path
          fill_in 'title', with: '洗濯'
          select '完了', from: 'status'
          click_button '検索'
        end
        let(:expected_list) { [task4] }
        it_behaves_like '期待した順番で表示されること'
        let(:unexpected_list) { [task1, task2, task3] }
        it_behaves_like '期待しないタスクが表示されないこと'
      end
    end

    describe '検索機能 & ソート機能' do
      let!(:task1) { FactoryBot.create(:task, title: 'う　買い物に行く', status: 'done', user: login_user) }
      let!(:task2) { FactoryBot.create(:task, title: 'あ　料理をする', status: 'doing', user: login_user) }
      let!(:task3) { FactoryBot.create(:task, title: 'い　食べる', status: 'todo', user: login_user) }
      let!(:task4) { FactoryBot.create(:task, title: 'え　洗濯する', status: 'done', user: login_user) }
      before do
        visit root_path
        fill_in 'title', with: 'る'
        click_button '検索'
        click_link nil, id: 'status_asc'
      end
      let(:expected_list) { [task3, task2, task4] }
      it_behaves_like '期待した順番で表示されること'
      let(:unexpected_list) { [task1] }
      it_behaves_like '期待しないタスクが表示されないこと'
    end

    describe 'ページネーション機能' do
      let!(:tasks) { FactoryBot.create_list(:task, 12, user: login_user) }
      context '1ページ目' do
        before do
          visit root_path
        end
        let(:expected_list) { [tasks[11], tasks[10], tasks[9], tasks[8], tasks[7], tasks[6], tasks[5], tasks[4], tasks[3], tasks[2]] }
        it_behaves_like '期待した順番で表示されること'
        let(:unexpected_list) { [tasks[1], tasks[0]] }
        it_behaves_like '期待しないタスクが表示されないこと'
      end
      context '2ページ目' do
        before do
          visit root_path
          click_link '2'
        end
        let(:expected_list) { [tasks[1], tasks[0]] }
        it_behaves_like '期待した順番で表示されること'
        let(:unexpected_list) { [tasks[11], tasks[10], tasks[9], tasks[8], tasks[7], tasks[6], tasks[5], tasks[4], tasks[3], tasks[2]] }
        it_behaves_like '期待しないタスクが表示されないこと'
      end
    end

    describe '検索機能 & ソート機能 & ページネーション機能' do
      let!(:task1) { FactoryBot.create(:task, title: 'task01!', created_at: Time.current + 1.day, user: login_user) }
      let!(:task2) { FactoryBot.create(:task, title: 'task02!', created_at: Time.current + 2.days, user: login_user) }
      let!(:task3) { FactoryBot.create(:task, title: 'task03', created_at: Time.current + 3.days, user: login_user) }
      let!(:task4) { FactoryBot.create(:task, title: 'task04!', created_at: Time.current + 4.days, user: login_user) }
      let!(:task5) { FactoryBot.create(:task, title: 'task05!', created_at: Time.current + 5.days, user: login_user) }
      let!(:task6) { FactoryBot.create(:task, title: 'task06!', created_at: Time.current + 6.days, user: login_user) }
      let!(:task7) { FactoryBot.create(:task, title: 'task07!', created_at: Time.current + 7.days, user: login_user) }
      let!(:task8) { FactoryBot.create(:task, title: 'task08!', created_at: Time.current + 8.days, user: login_user) }
      let!(:task9) { FactoryBot.create(:task, title: 'task09!', created_at: Time.current + 9.days, user: login_user) }
      let!(:task10) { FactoryBot.create(:task, title: 'task10', created_at: Time.current + 10.days, user: login_user) }
      let!(:task11) { FactoryBot.create(:task, title: 'task11!', created_at: Time.current + 11.days, user: login_user) }
      let!(:task12) { FactoryBot.create(:task, title: 'task12!', created_at: Time.current + 12.days, user: login_user) }
      let!(:task13) { FactoryBot.create(:task, title: 'task13!', created_at: Time.current + 12.days, user: login_user) }
      let!(:task14) { FactoryBot.create(:task, title: 'task14!', created_at: Time.current + 12.days, user: login_user) }
      context '1ページ目' do
        before do
          visit root_path
          fill_in 'title', with: '!'
          click_button '検索'
          click_link nil, id: 'created_at_asc'
        end
        let(:expected_list) { [task1, task2, task4, task5, task6, task7, task8, task9, task11, task12] }
        it_behaves_like '期待した順番で表示されること'
        let(:unexpected_list) { [task13, task14, task3, task10] }
        it_behaves_like '期待しないタスクが表示されないこと'
      end
      context '2ページ目' do
        before do
          visit root_path
          fill_in 'title', with: '!'
          click_button '検索'
          click_link nil, id: 'created_at_asc'
          click_link '2'
        end
        let(:expected_list) { [task13, task14] }
        it_behaves_like '期待した順番で表示されること'
        let(:unexpected_list) { [task1, task2, task4, task5, task6, task7, task8, task9, task11, task12, task3, task10 ] }
        it_behaves_like '期待しないタスクが表示されないこと'
      end
    end
  end

  describe '#show(task_id)' do
    let!(:task) { FactoryBot.create(:task, user: login_user) }
    before do
      visit task_path task.id
    end

    it '期待したタスクが表示されること' do
      expect(find('#task_title').value).to eq task['title']
      expect(find('#task_detail').value).to eq task['detail']
      expect(find('#task_end_date').value).to eq task['end_date'].strftime('%Y-%m-%d')
      expect(find('#task_status').value).to eq task['status']
    end
  end

  describe '#edit(task_id)' do
    let!(:task) { FactoryBot.create(:task, user: login_user) }
    let(:edited_task) {
      {
        'title' => '買い物に行く',
        'detail' => '卵、牛乳、人参',
        'end_date' => Time.zone.today + 1.week,
        'status' => 'doing',
      } }
    before do
      visit edit_task_path task.id
      fill_in 'task[title]', with: edited_task['title']
      fill_in 'task[detail]', with: edited_task['detail']
      fill_in 'task[end_date]', with: edited_task['end_date']
      find('#task_status').find("option[value=#{edited_task['status']}]").select_option
      click_button '更新する'
    end

    it '期待したタスクが表示されること' do
      is_expected.to have_current_path task_path task.id
      expect(find('#task_title').value).to eq edited_task['title']
      expect(find('#task_detail').value).to eq edited_task['detail']
      expect(find('#task_end_date').value).to eq edited_task['end_date'].strftime('%Y-%m-%d')
      expect(find('#task_status').value).to eq edited_task['status']
      is_expected.to have_selector('.alert-success', text: 'タスクが更新されました！')
    end
  end

  describe '#new' do
    let(:new_task) {
      {
        'title' => '美容院に行く',
        'detail' => 'ヘアサロン・ラクマ',
        'end_date' => Time.zone.today - 1.week,
        'status' => 'done',
      }
    }
    before do
      visit new_task_path
      fill_in 'task[title]', with: new_task['title']
      fill_in 'task[detail]', with: new_task['detail']
      fill_in 'task[end_date]', with: new_task['end_date']
      find('#task_status').find("option[value=#{new_task['status']}]").select_option
      click_button '登録する'
    end

    it '期待したタスクが表示されること' do
      is_expected.to have_current_path root_path
      is_expected.to have_content new_task['title']
      is_expected.to have_content new_task['detail']
      is_expected.to have_content new_task['end_date'].strftime('%Y/%m/%d')
      is_expected.to have_selector('.alert-success', text: '新しいタスクが登録されました！')
    end
  end

  describe '#destroy(task_id)' do
    let!(:task) { FactoryBot.create(:task, title: '七辻屋に行く', detail: '大福', user: login_user) }
    before do
      visit root_path
      click_link nil, href: task_path(task), class: 'delete-link'
    end

    it '削除した登録済みタスクが表示されないこと' do
      is_expected.to have_current_path root_path
      is_expected.to have_no_content task.title
      is_expected.to have_no_content task.detail
      is_expected.to have_selector('.alert-success', text: 'タスクが削除されました！')
    end
  end
end
