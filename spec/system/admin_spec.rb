require 'rails_helper'

RSpec.describe 'admin page', type: :system do
  describe 'adminページトップ' do
    before do
      5.times do |user_idx|
        create(:user, name: "user_#{user_idx}",
                      email: "user_#{user_idx}@example.com",
                      password: 'password',
                      password_confirmation: 'password')
      end
      visit admin_index_path
    end

    context '/adminにアクセスしたとき' do
      it 'ユーザ一覧が表示される' do
        5.times do |user_idx|
          expect(page).to have_content "user_#{user_idx}"
        end
      end
    end

    context 'ユーザ名を押したとき' do
      it '詳細ページが表示される' do
        click_on 'user_0'
        expect(page).to     have_content 'user_0'
        expect(page).not_to have_content 'user_1'
      end
    end
  end
end