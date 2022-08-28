require 'rails_helper'

RSpec.describe 'admin page', type: :system do
  describe 'adminページトップ' do
    let(:admin_user) {create(:user, name:  'admin',
                                    email: 'admin@example.com')}
    before do
      5.times do |user_idx|
        create(:user, name: "user_#{user_idx}",
                      email: "user_#{user_idx}@example.com",
                      password: 'password',
                      password_confirmation: 'password')
      end
      login_as(admin_user)
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

    context '削除ボタンを押したとき' do
      it 'ユーザが削除される' do
        id = User.first.id

        # 削除するユーザ
        expect(page).to have_content("user_#{id}")

        # ユーザに割り当てられた削除ボタンを押す
        find(".delete_user_#{id}").click 

        # 確認のポップアップが表示される
        expect(page.accept_confirm).to eq '本当に削除しますか?'

        # 削除の成功のメッセージが表示される
        expect(page).to     have_content('ユーザを削除しました')

        # 削除されたユーザはadminページからも消える
        expect(page).not_to have_content("user_#{id}")
      end
    end
  end
end