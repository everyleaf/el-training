require 'rails_helper'

RSpec.describe 'Categories', type: :system do
  describe 'ユーザログイン' do
    let!(:user) { create(:user, email: 'registered_user@example.com') }
    before do
      visit login_path
    end

    context '登録済のユーザ情報を入力したとき' do
      it 'ログインに成功する' do
        fill_in 'session_email', with: user.email
        fill_in 'session_password', with: user.password
        click_on 'Log in'

        expect(page).to have_content('ログインしました')
      end
    end

    context '登録していないのユーザ情報を入力したとき' do
      it 'ログインに成功する' do
        fill_in 'session_email', with: 'not_registered_user@example.com'
        fill_in 'session_password', with: 'not_registered'
        click_on 'Log in'

        expect(page).to have_content('ログイン情報が間違っています')
      end
    end

    context '認証されていないユーザ情報を入力したとき' do
      let!(:not_activated_user) { create(:user, activated: false) }
      before do
        fill_in 'session_email',    with: not_activated_user.email
        fill_in 'session_password', with: not_activated_user.password
        click_on 'Log in'
      end

      it 'ログインできない' do
        expect(page).to     have_content('アカウントを作成')
        expect(page).not_to have_content('タスク一覧')
      end

      it 'メールを確認するメッセージが表示される' do
        expect(page).to have_content(I18n.t('please_activate'))
      end
    end
  end
end
