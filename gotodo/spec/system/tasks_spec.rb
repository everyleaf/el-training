# frozen_string_literal: true

require 'rails_helper'
require 'pp'

RSpec.describe 'Tasks', type: :system do
  let!(:added_task) { FactoryBot.create(:task_a) }

  shared_examples '登録済みタスクが表示されること' do
    it { expect(page).to have_content(added_task.task_name) }
  end
  shared_examples '編集したタスクが表示されること' do
    it { expect(page).to have_content(edit_task.task_name) }
  end
  shared_examples '新規登録したタスクが表示されること' do
    it { expect(page).to have_content(new_task.task_name) }
  end
  shared_examples '削除した登録済みタスクが表示されないこと' do
    it { expect(page).to have_no_content(added_task.task_name) }
  end

  describe '#index' do
    before do
      visit root_path
    end
    it_behaves_like '登録済みタスクが表示されること'
  end

  describe '#show' do
    before do
      visit task_path added_task.id
    end
    it_behaves_like '登録済みタスクが表示されること'
  end

  describe '#edit' do
    let(:edit_task) { FactoryBot.build(:task_b) }
    before do
      visit edit_task_path added_task.id
      fill_in 'タスク名', with: edit_task.task_name
      fill_in '詳細', with: edit_task.detail
      click_button 'Update Task'
    end
    it_behaves_like '編集したタスクが表示されること'
  end

  describe '#new' do
    let(:new_task) { FactoryBot.create(:task_b) }
    before do
      visit new_task_path
      fill_in 'タスク名', with: new_task.task_name
      fill_in '詳細', with: new_task.detail
      click_button 'Create Task'
    end
    it_behaves_like '新規登録したタスクが表示されること'
  end

  describe '#destroy' do
    before do
      visit root_path
      click_link 'Destroy', href: task_path(added_task)
    end
    it_behaves_like '削除した登録済みタスクが表示されないこと'
  end
end
