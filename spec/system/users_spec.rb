RSpec.describe 'Users', type: :system do
  describe 'ユーザの作成' do
    before do
      visit new_user_url
    end
    context '全ての項目を正しく埋めたとき' do
      it 'ユーザの作成に成功する' do
        fill_in 'user_name',                  with: 'user'
        fill_in 'user_email',                 with: 'user@example.com'
        fill_in 'user_password',              with: 'password'
        fill_in 'user_password_confirmation', with: 'password'

        click_on 'create'

        expect(page).to have_content('ユーザを作成しました')
      end
    end
  end
end