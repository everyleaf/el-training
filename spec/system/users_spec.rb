RSpec.describe 'Users', type: :system do
  describe 'ユーザの作成' do
    before do
      visit new_user_path
    end

    context '全ての項目を正しく埋めたとき' do
      it 'アカウント有効化のメールが送信される' do
        fill_in 'user_name',                  with: 'user'
        fill_in 'user_email',                 with: 'user@example.com'
        fill_in 'user_password',              with: 'password'
        fill_in 'user_password_confirmation', with: 'password'

        click_on 'Create'
        
        expect(page).to have_content('登録したアドレスにメールを送信しました')
      end
    end

    context 'ユーザ名が空のとき' do
      it 'ユーザの作成に失敗する' do
        fill_in 'user_name',                  with: ''
        fill_in 'user_email',                 with: 'user@example.com'
        fill_in 'user_password',              with: 'password'
        fill_in 'user_password_confirmation', with: 'password'

        click_on 'Create'

        expect(page).to have_content('ユーザの作成に失敗しました')
        expect(page).to have_content('ユーザ名を入力してください')
      end
    end

    context 'メールアドレスが有効でないとき' do
      it 'ユーザの作成に失敗する' do
        fill_in 'user_name',                  with: 'user'
        fill_in 'user_email',                 with: 'invalid_email'
        fill_in 'user_password',              with: 'password'
        fill_in 'user_password_confirmation', with: 'password'

        click_on 'Create'

        expect(page).to have_content('ユーザの作成に失敗しました')
        expect(page).to have_content('メールアドレスは不正な値です')
      end
    end

    context 'パスワードが再確認用と一致しないとき' do
      it 'ユーザの作成に失敗する' do
        fill_in 'user_name',                  with: 'user'
        fill_in 'user_email',                 with: 'invalid_email'
        fill_in 'user_password',              with: 'password'
        fill_in 'user_password_confirmation', with: 'qawsedrf'

        click_on 'Create'

        expect(page).to have_content('ユーザの作成に失敗しました')
        expect(page).to have_content('パスワード確認とパスワードの入力が一致しません')
      end
    end
  end
end
