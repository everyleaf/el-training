# frozen_string_literal: true

require 'rails_helper'
require 'pp'

RSpec.describe 'Tasks', type: :system do
  let!(:task1) { FactoryBot.create(:task, title: 'う　買い物に行く', detail: '卵、牛乳', end_date: Time.zone.today + 2.weeks) }
  let!(:task2) { FactoryBot.create(:task, title: 'あ　料理をする', end_date: Time.zone.today + 1.week, created_at: Time.current + 2.days) }
  let!(:task3) { FactoryBot.create(:task, title: 'い　食べる', end_date: Time.zone.today + 3.weeks, created_at: Time.current + 3.days) }
  subject { page }

  shared_examples '期待したページに遷移すること' do
    it { is_expected.to have_current_path target_path }
  end

  shared_examples '期待したタスクが表示されること' do
    it { is_expected.to have_content task.title }
    it { is_expected.to have_content task.detail }
  end

  shared_examples '期待したFlashメッセージが表示されること' do
    it { is_expected.to have_selector('#notice', text: message) }
  end

  describe '#index' do
    let(:task) { task1 }
    before do
      visit root_path
    end

    it_behaves_like '期待したタスクが表示されること'

    describe 'ソート機能' do
      shared_examples '期待した順番で表示されること' do
        it do
          hash = { 'asc' => '▲', 'desc' => '▼' }
          click_link hash[direction], href: tasks_path(sort: sort, direction: direction)
          task_list = all('tbody tr')
          task_list.each_with_index do |task, i|
            expect(task).to have_content expected_list[i].title
          end
        end
      end
      context 'タスク名昇順' do
        let(:expected_list) { [task2, task3, task1] }
        let(:sort) { 'title' }
        let(:direction) { 'asc' }
        it_behaves_like '期待した順番で表示されること'
      end
      context 'タスク名降順' do
        let(:expected_list) { [task1, task3, task2] }
        let(:sort) { 'title' }
        let(:direction) { 'desc' }
        it_behaves_like '期待した順番で表示されること'
      end
      context '作成日時昇順' do
        let(:expected_list) { [task1, task2, task3] }
        let(:sort) { 'created_at' }
        let(:direction) { 'asc' }
        it_behaves_like '期待した順番で表示されること'
      end
      context '作成日時降順' do
        let(:expected_list) { [task3, task2, task1] }
        let(:sort) { 'created_at' }
        let(:direction) { 'desc' }
        it_behaves_like '期待した順番で表示されること'
      end
      context '終了期限昇順' do
        let(:expected_list) { [task2, task1, task3] }
        let(:sort) { 'end_date' }
        let(:direction) { 'asc' }
        it_behaves_like '期待した順番で表示されること'
      end
      context '終了期限降順' do
        let(:expected_list) { [task3, task1, task2] }
        let(:sort) { 'end_date' }
        let(:direction) { 'desc' }
        it_behaves_like '期待した順番で表示されること'
      end
    end
  end

  describe '#show(task_id)' do
    let(:task) { task1 }
    before do
      visit task_path task1.id
    end

    it_behaves_like '期待したタスクが表示されること'
  end

  describe '#edit(task_id)' do
    let(:task) { FactoryBot.build(:task, title: '買い物に行く', detail: '卵、牛乳、人参') }
    let(:target_path) { task_path task1.id }
    let(:message) { 'タスクが更新されました！' }
    before do
      visit edit_task_path task1.id
      fill_in 'タスク名', with: task.title
      fill_in '詳細', with: task.detail
      click_button '更新する'
    end

    it_behaves_like '期待したページに遷移すること'
    it_behaves_like '期待したタスクが表示されること'
    it_behaves_like '期待したFlashメッセージが表示されること'
  end

  describe '#new' do
    let(:task) { FactoryBot.build(:task, title: '美容院に行く', detail: 'ヘアサロン・ラクマ') }
    let(:target_path) { task_path Task.last.id }
    let(:message) { '新しいタスクが登録されました！' }
    before do
      visit new_task_path
      fill_in 'タスク名', with: task.title
      fill_in '詳細', with: task.detail
      click_button '登録する'
    end

    it_behaves_like '期待したページに遷移すること'
    it_behaves_like '期待したタスクが表示されること'
    it_behaves_like '期待したFlashメッセージが表示されること'
  end

  describe '#destroy(task_id)' do
    before do
      visit root_path
      click_link nil, href: task_path(task1), class: 'delete-link'
    end
    let(:message) { 'タスクが削除されました！' }

    it '削除した登録済みタスクが表示されないこと' do
      is_expected.to have_current_path root_path
      is_expected.to have_no_content task1.title
      is_expected.to have_no_content task1.detail
    end

    it_behaves_like '期待したFlashメッセージが表示されること'
  end
end
