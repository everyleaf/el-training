# frozen_string_literal: true

require 'rails_helper'

RSpec.describe SessionsController, js: true, type: :system do
  let(:password) { 'password' }
  let!(:login_user) { create(:user, password: password) }
  before do
    visit login_path
    sleep(0.3)
  end

  describe '#new' do
    it 'should render login page' do
      expect(page).to have_content 'Email'
      expect(page).to have_content 'パスワード'
    end
  end

  describe '#create' do
    before do
      fill_in 'session_email', with: login_user.email
      fill_in 'session_password', with: password
    end

    it 'should login' do
      expect { click_button 'ログイン' }.to change { current_path }.from(login_path).to(tasks_path)
    end
  end

  describe '#destroy', :require_login do
    before do
      fill_in 'session_email', with: login_user.email
      fill_in 'session_password', with: password
      click_button 'ログイン'
      sleep(0.2)
    end

    subject do
      click_link 'ログアウト'
      sleep(0.2)
    end

    it 'render to login page' do
      expect { subject }.to change {
        current_path
      }.from(tasks_path).to(login_path)
    end
  end
end
