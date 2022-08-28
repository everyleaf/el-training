require 'rails_helper'

RSpec.describe 'admin page', type: :system do
  let(:admin_user) {
    create(:user, name: 'admin',
                  email: 'admin@example.com')
  }
  before do
    5.times do |user_idx|
      create(:user, name: "user_#{user_idx}",
                    email: "user_#{user_idx}@example.com",
                    password: 'password',
                    password_confirmation: 'password')
    end
    login_as(admin_user)
  end

  describe 'adminページトップ' do
    before do
      visit admin_index_path
    end

    context '/adminにアクセスしたとき' do
      it 'ユーザ一覧が表示される' do
        5.times do |user_idx|
          expect(page).to have_content "user_#{user_idx}"
        end
      end
    end

    context '削除ボタンを押したとき' do
      it 'ユーザが削除される' do
        id = User.find_by(name: 'user_0').id

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

  describe 'adminページ詳細' do
    context 'adminページトップでユーザ名を押したとき' do
      before do
        visit admin_index_path
      end

      it '詳細ページが表示される' do
        click_on 'user_0'
        expect(page).to have_content 'ユーザ情報'
        expect(page).to have_content 'カテゴリ一覧'
        expect(page).to have_content 'タスク一覧'
      end
    end

    context '削除ボタンを押したとき' do
      it 'ユーザが削除される' do
        # 削除するユーザ
        id = User.find_by(name: 'user_0').id

        # 詳細ページへ移動
        visit admin_path(id)

        # ユーザに割り当てられた削除ボタンを押す
        click_on 'ユーザを削除'

        # 確認のポップアップが表示される
        expect(page.accept_confirm).to eq '本当に削除しますか?'

        # 削除の成功のメッセージが表示される
        expect(page).to have_content('ユーザを削除しました')
      end
    end
  end
end
