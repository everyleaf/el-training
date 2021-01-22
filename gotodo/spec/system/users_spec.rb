# frozen_string_literal: true

require 'rails_helper'
require 'pp'

RSpec.describe 'Users', type: :system do
  let!(:user1) { FactoryBot.create(:user) }
  subject { page }

  before 'ログイン' do
    visit login_path
    fill_in 'email', with: user1.email
    fill_in 'password', with: user1.password
    click_button 'ログイン'
  end

  describe 'アクセス権' do
    context 'ログイン状態の時' do
      it '#newにアクセスできること' do
        visit new_user_path
        is_expected.to have_current_path new_user_path
      end
    end

    context '未ログイン状態の時' do
      before do
        click_link nil, href: logout_path
      end
      it '#newにアクセスできること' do
        visit new_user_path
        is_expected.to have_current_path new_user_path
      end
    end
  end

  describe '#new' do
    let(:new_user) {
      {
        'name' => 'ニャンコ先生',
        'email' => 'nyanko@example.com',
        'password' => 'xxx',
        'password_confirmation' => 'xxx',
      }
    }
    before do
      visit new_user_path
      fill_in 'user[name]', with: new_user['name']
      fill_in 'user[email]', with: new_user['email']
      fill_in 'user[password]', with: new_user['password']
      fill_in 'user[password_confirmation]', with: new_user['password_confirmation']
      click_button '登録する'
    end

    it '新規作成したユーザでログインできること' do
      is_expected.to have_current_path root_path
      is_expected.to have_selector('.alert-success', text: '新しいユーザーが登録されました！')

      click_link nil, href: logout_path
      is_expected.to have_current_path login_path
      fill_in 'email', with: new_user['email']
      fill_in 'password', with: new_user['password']
      click_button 'ログイン'

      is_expected.to have_current_path root_path
      is_expected.to have_selector('.alert-success', text: "ようこそ、#{new_user['name']}さん")
    end
  end
end
