# frozen_string_literal: true

require 'rails_helper'
require 'pp'

RSpec.describe 'Tasks', type: :system do
  let!(:added_task) { FactoryBot.create(:task, title: '買い物に行く', detail: '卵、牛乳') }

  describe '#index' do
    before do
      visit root_path
    end
    it '登録済みタスクが表示されること' do
      expect(page).to have_content added_task.title
      expect(page).to have_content added_task.detail
    end
  end

  describe '#show(task_id)' do
    before do
      visit task_path added_task.id
    end
    it '登録済みタスクが表示されること' do
      expect(page).to have_content added_task.title
      expect(page).to have_content added_task.detail
    end
  end

  describe '#edit(task_id)' do
    let(:edited_task) { FactoryBot.build(:task, title: '買い物に行く', detail: '卵、牛乳、人参') }
    before do
      visit edit_task_path added_task.id
      fill_in 'タスク名', with: edited_task.title
      fill_in '詳細', with: edited_task.detail
      click_button '更新する'
    end
    it '編集したタスクが表示されること' do
      expect(page).to have_current_path task_path added_task.id
      expect(page).to have_content edited_task.title
      expect(page).to have_content edited_task.detail
    end
    it 'Flashメッセージが表示されること' do
      expect(page).to have_selector('#notice', text: 'タスクが更新されました！')
    end
  end

  describe '#new' do
    let(:new_task) { FactoryBot.create(:task, title: '美容院に行く', detail: 'ヘアサロン・ラクマ') }
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
      click_link nil, href: task_path(added_task), class: 'delete-link'
    end
    it '削除した登録済みタスクが表示されないこと' do
      expect(page).to have_current_path root_path
      expect(page).to have_no_content added_task.title
      expect(page).to have_no_content added_task.detail
    end
    it 'Flashメッセージが表示されること' do
      expect(page).to have_selector('#notice', text: 'タスクが削除されました！')
    end
  end
end
