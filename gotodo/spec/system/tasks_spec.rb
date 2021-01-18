# frozen_string_literal: true

require 'rails_helper'
require 'pp'

RSpec.describe 'Tasks', type: :system do
  let!(:user) { FactoryBot.create(:user) }
  let!(:task1) { FactoryBot.create(:task, title: 'う　買い物に行く', detail: '卵、牛乳', end_date: Time.zone.today + 2.weeks, status: 'done') }
  let!(:task2) { FactoryBot.create(:task, title: 'あ　料理をする', end_date: Time.zone.today + 1.week, created_at: Time.current + 2.days, status: 'doing') }
  let!(:task3) { FactoryBot.create(:task, title: 'い　食べる', end_date: Time.zone.today + 3.weeks, created_at: Time.current + 3.days, status: 'todo') }
  let!(:task4) { FactoryBot.create(:task, title: 'え　洗濯する', end_date: Time.zone.today + 4.weeks, created_at: Time.current + 4.days, status: 'done') }
  subject { page }

  describe '#index' do
    before do
      visit root_path
    end

    shared_examples '期待した順番で表示されること' do
      # 【備考】 条件が同じ場合はidが若い順番になる
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

    it '期待したタスクが表示されること' do
      is_expected.to have_content task1.title
      is_expected.to have_content task1.detail
    end

    describe 'ソート機能' do
      describe 'タスク名' do
        context '昇順' do
          before do
            click_link nil, id: 'title_asc'
          end
          let(:expected_list) { [task2, task3, task1, task4] }
          it_behaves_like '期待した順番で表示されること'
        end
        context '降順' do
          before do
            click_link nil, id: 'title_desc'
          end
          let(:expected_list) { [task4, task1, task3, task2] }
          it_behaves_like '期待した順番で表示されること'
        end
      end
      describe '作成日時' do
        context '昇順' do
          before do
            click_link nil, id: 'created_at_asc'
          end
          let(:expected_list) { [task1, task2, task3, task4] }
          it_behaves_like '期待した順番で表示されること'
        end
        context '降順' do
          before do
            click_link nil, id: 'created_at_desc'
          end
          let(:expected_list) { [task4, task3, task2, task1] }
          it_behaves_like '期待した順番で表示されること'
        end
      end
      describe '終了期限' do
        context '昇順' do
          before do
            click_link nil, id: 'end_date_asc'
          end
          let(:expected_list) { [task2, task1, task3, task4] }
          it_behaves_like '期待した順番で表示されること'
        end
        context '降順' do
          before do
            click_link nil, id: 'end_date_desc'
          end
          let(:expected_list) { [task4, task3, task1, task2] }
          it_behaves_like '期待した順番で表示されること'
        end
      end
      describe 'ステータス' do
        context '昇順' do
          before do
            click_link nil, id: 'status_asc'
          end
          let(:expected_list) { [task3, task2, task1, task4] }
          it_behaves_like '期待した順番で表示されること'
        end
        context '降順' do
          before do
            click_link nil, id: 'status_desc'
          end
          let(:expected_list) { [task1, task4, task2, task3] }
          it_behaves_like '期待した順番で表示されること'
        end
      end
    end

    describe '検索機能' do
      context 'タスク名を指定' do
        before do
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
          select '完了', from: 'status'
          click_button '検索'
        end
        let(:expected_list) { [task1, task4] }
        it_behaves_like '期待した順番で表示されること'
        let(:unexpected_list) { [task2, task3] }
        it_behaves_like '期待しないタスクが表示されないこと'
      end
      context 'タスク名とステータスを指定' do
        before do
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
      before do
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
      let!(:task1) { FactoryBot.create(:task, title: 'task01', created_at: Time.current + 1.day) }
      let!(:task2) { FactoryBot.create(:task, title: 'task02', created_at: Time.current + 2.days) }
      let!(:task3) { FactoryBot.create(:task, title: 'task03', created_at: Time.current + 3.days) }
      let!(:task4) { FactoryBot.create(:task, title: 'task04', created_at: Time.current + 4.days) }
      let!(:task5) { FactoryBot.create(:task, title: 'task05', created_at: Time.current + 5.days) }
      let!(:task6) { FactoryBot.create(:task, title: 'task06', created_at: Time.current + 6.days) }
      let!(:task7) { FactoryBot.create(:task, title: 'task07', created_at: Time.current + 7.days) }
      let!(:task8) { FactoryBot.create(:task, title: 'task08', created_at: Time.current + 8.days) }
      let!(:task9) { FactoryBot.create(:task, title: 'task09', created_at: Time.current + 9.days) }
      let!(:task10) { FactoryBot.create(:task, title: 'task10', created_at: Time.current + 10.days) }
      let!(:task11) { FactoryBot.create(:task, title: 'task11', created_at: Time.current + 11.days) }
      let!(:task12) { FactoryBot.create(:task, title: 'task12', created_at: Time.current + 12.days) }
      context '1ページ目' do
        before do
          visit root_path
        end
        let(:expected_list) { [task1, task2, task3, task4, task5, task6, task7, task8, task9, task10] }
        it_behaves_like '期待した順番で表示されること'
        let(:unexpected_list) { [task11, task12] }
        it_behaves_like '期待しないタスクが表示されないこと'
      end
      context '2ページ目' do
        before do
          visit root_path
          click_link '2'
        end
        let(:expected_list) { [task11, task12] }
        it_behaves_like '期待した順番で表示されること'
        let(:unexpected_list) { [task1, task2, task3, task4, task5, task6, task7, task8, task9, task10] }
        it_behaves_like '期待しないタスクが表示されないこと'
      end
    end

    describe '検索機能 & ソート機能 & ページネーション機能' do
      let!(:task1) { FactoryBot.create(:task, title: 'task01!', created_at: Time.current + 1.day) }
      let!(:task2) { FactoryBot.create(:task, title: 'task02!', created_at: Time.current + 2.days) }
      let!(:task3) { FactoryBot.create(:task, title: 'task03', created_at: Time.current + 3.days) }
      let!(:task4) { FactoryBot.create(:task, title: 'task04!', created_at: Time.current + 4.days) }
      let!(:task5) { FactoryBot.create(:task, title: 'task05!', created_at: Time.current + 5.days) }
      let!(:task6) { FactoryBot.create(:task, title: 'task06!', created_at: Time.current + 6.days) }
      let!(:task7) { FactoryBot.create(:task, title: 'task07!', created_at: Time.current + 7.days) }
      let!(:task8) { FactoryBot.create(:task, title: 'task08!', created_at: Time.current + 8.days) }
      let!(:task9) { FactoryBot.create(:task, title: 'task09!', created_at: Time.current + 9.days) }
      let!(:task10) { FactoryBot.create(:task, title: 'task10', created_at: Time.current + 10.days) }
      let!(:task11) { FactoryBot.create(:task, title: 'task11!', created_at: Time.current + 11.days) }
      let!(:task12) { FactoryBot.create(:task, title: 'task12!', created_at: Time.current + 12.days) }
      let!(:task13) { FactoryBot.create(:task, title: 'task13!', created_at: Time.current + 12.days) }
      let!(:task14) { FactoryBot.create(:task, title: 'task14!', created_at: Time.current + 12.days) }
      context '1ページ目' do
        before do
          visit root_path
          fill_in 'title', with: '!'
          click_button '検索'
          click_link nil, id: 'created_at_desc'
        end
        let(:expected_list) { [task14, task13, task12, task11, task9, task8, task7, task6, task5, task4] }
        it_behaves_like '期待した順番で表示されること'
        let(:unexpected_list) { [task10, task3, task2, task1] }
        it_behaves_like '期待しないタスクが表示されないこと'
      end
      context '2ページ目' do
        before do
          visit root_path
          fill_in 'title', with: '!'
          click_button '検索'
          click_link nil, id: 'created_at_desc'
          click_link '2'
        end
        let(:expected_list) { [task2, task1] }
        it_behaves_like '期待した順番で表示されること'
        let(:unexpected_list) { [task14, task13, task12, task11, task10, task9, task8, task7, task6, task5, task4, task3] }
        it_behaves_like '期待しないタスクが表示されないこと'
      end
    end
  end

  describe '#show(task_id)' do
    before do
      visit task_path task1.id
    end

    it '期待したタスクが表示されること' do
      is_expected.to have_content task1.title
      is_expected.to have_content task1.detail
    end
  end

  describe '#edit(task_id)' do
    let(:edited_task) {
      {
        'title' => '買い物に行く',
        'detail' => '卵、牛乳、人参',
        'end_date' => Time.zone.today + 1.week,
        'status' => 'doing',
      } }
    before do
      visit edit_task_path task1.id
      fill_in 'task[title]', with: edited_task['title']
      fill_in 'task[detail]', with: edited_task['detail']
      fill_in 'task[end_date]', with: edited_task['end_date']
      find('#task_status').find("option[value=#{edited_task['status']}]").select_option
      click_button '更新する'
    end

    it '期待したタスクが表示されること' do
      is_expected.to have_current_path task_path task1.id
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
      is_expected.to have_current_path task_path Task.last.id
      expect(find('#task_title').value).to eq new_task['title']
      expect(find('#task_detail').value).to eq new_task['detail']
      expect(find('#task_end_date').value).to eq new_task['end_date'].strftime('%Y-%m-%d')
      expect(find('#task_status').value).to eq new_task['status']
      is_expected.to have_selector('.alert-success', text: '新しいタスクが登録されました！')
    end
  end

  describe '#destroy(task_id)' do
    before do
      visit root_path
      click_link nil, href: task_path(task1), class: 'delete-link'
    end

    it '削除した登録済みタスクが表示されないこと' do
      is_expected.to have_current_path root_path
      is_expected.to have_no_content task1.title
      is_expected.to have_no_content task1.detail
      is_expected.to have_selector('.alert-success', text: 'タスクが削除されました！')
    end
  end
end
