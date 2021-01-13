# frozen_string_literal: true

module AdminHelper
  shared_context 'admin' do
    let!(:login_user) { create(:user, :with_admin, email: login_user_email, password: login_user_password, password_confirmation: login_user_password) }
    before do
      visit login_path
      fill_in 'session_email', with: login_user.email
      fill_in 'session_password', with: login_user_password
      click_button 'ログイン'
    end
  end

  shared_examples 'when login as a member' do
    let!(:login_user) { create(:user, email: login_user_email, password: login_user_password, password_confirmation: login_user_password) }
    before do
      visit login_path
      fill_in 'session_email', with: login_user.email
      fill_in 'session_password', with: login_user_password
      click_button 'ログイン'
    end

    it 'redirect to task list page' do
      visit admin_users_path
      expect(current_path).to eq tasks_path
    end
  end

  shared_examples 'when not logged in yet' do
    it 'redirect to login' do
      visit admin_users_path
      expect(current_path).to eq login_path
    end
  end
end
