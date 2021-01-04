# frozen_string_literal: true

require 'rails_helper'
require 'pp'

RSpec.describe 'Tasks', type: :system do
  let!(:task1) { FactoryBot.create(:task, title: '買い物に行く', detail: '卵、牛乳') }
  let!(:task2) { FactoryBot.create(:task, title: '料理をする', created_at: Time.current + 2.days) }
  let!(:task3) { FactoryBot.create(:task, title: '食べる', created_at: Time.current + 3.days) }

  describe '#index' do
    before do
      visit root_path
    end
    it '登録済みタスクが表示されること' do
      expect(page).to have_content task1.title
      expect(page).to have_content task1.detail
    end
    context 'ソート用セレクトボックスを選択した時' do
      it '作成日時降順で並び替えられること', js: true do
        find("select[name='sort']").find("option[value='created_desc']").select_option
        task_list = all('tbody tr')
        truth_list = [task3, task2, task1]
        task_list.each_with_index do |task, i|
          expect(task).to have_content truth_list[i].title
        end
      end
      it 'ID昇順で並び替えられること', js: true do
        find("select[name='sort']").find("option[value='id_asc']").select_option
        task_list = all('tbody tr')
        truth_list = [task1, task2, task3]
        task_list.each_with_index do |task, i|
          expect(task).to have_content truth_list[i].title
        end
      end
    end
  end

  describe '#show(task_id)' do
    before do
      visit task_path task1.id
    end
    it '登録済みタスクが表示されること' do
      expect(page).to have_content task1.title
      expect(page).to have_content task1.detail
    end
  end

  describe '#edit(task_id)' do
    let(:edited_task) { FactoryBot.build(:task, title: '買い物に行く', detail: '卵、牛乳、人参') }
    before do
      visit edit_task_path task1.id
      fill_in 'タスク名', with: edited_task.title
      fill_in '詳細', with: edited_task.detail
      click_button '更新する'
    end
    it '編集したタスクが表示されること' do
      expect(page).to have_current_path task_path edited_task.id
      expect(page).to have_content edited_task.title
      expect(page).to have_content edited_task.detail
    end
    it 'Flashメッセージが表示されること' do
      expect(page).to have_selector('#notice', text: 'タスクが更新されました！')
    end
  end

  describe '#new' do
    let(:new_task) { FactoryBot.build(:task, title: '美容院に行く', detail: 'ヘアサロン・ラクマ') }
    before do
      visit new_task_path
      fill_in 'タスク名', with: new_task.title
      fill_in '詳細', with: new_task.detail
      click_button '登録する'
    end
    it '新規登録したタスクが表示されること' do
      expect(page).to have_current_path task_path Task.last.id
      expect(page).to have_content new_task.title
      expect(page).to have_content new_task.detail
    end
    it 'Flashメッセージが表示されること' do
      expect(page).to have_selector('#notice', text: '新しいタスクが登録されました！')
    end
  end

  describe '#destroy(task_id)' do
    before do
      visit root_path
      click_link nil, href: task_path(task1), class: 'delete-link'
    end
    it '削除した登録済みタスクが表示されないこと' do
      expect(page).to have_current_path root_path
      expect(page).to have_no_content task1.title
      expect(page).to have_no_content task1.detail
    end
    it 'Flashメッセージが表示されること' do
      expect(page).to have_selector('#notice', text: 'タスクが削除されました！')
    end
  end
end
