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
      expect(page).to have_content 'ログインしたままにする'
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

    context 'when user does not let his browser to remember logged in' do
      before do
        click_button 'ログイン'
        sleep(0.3)
        login_user.reload
      end

      it 'does not have remember_token and user_id_token' do
        %w[user_id remember_token].each do |t|
          expect { page.driver.browser.manage.cookie_named(t) }.to raise_error(Selenium::WebDriver::Error::NoSuchCookieError)
        end
      end
    end

    context 'when user lets his browser to remember logged in' do
      before do
        check('session[remember_me]')
        click_button 'ログイン'
        sleep(0.3)
        login_user.reload
      end

      it 'has remember_token and user_id_token' do
        expect(page.driver.browser.manage.cookie_named('user_id')).not_to be_nil
        remember_token = page.driver.browser.manage.cookie_named('remember_token')[:value]
        expect(BCrypt::Password.new(login_user.remember_digest).is_password?(remember_token)).to be_truthy
      end
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

    it 'does not have remember_token and user_id_token' do
      expect { page.driver.browser.manage.cookie_named('user_id') }.to raise_error(Selenium::WebDriver::Error::NoSuchCookieError)
    end
  end
end
