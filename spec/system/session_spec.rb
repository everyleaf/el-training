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
  end

  describe 'タスクCRUDの認可' do
    let!(:user_1) { create(:user, email: "user_1@example.com") }
    let!(:user_2) { create(:user, email: "user_2@example.com") }
    let!(:category_1) { create(:category, user: user_1) }
    let!(:category_2) { create(:category, user: user_2) }
    let!(:task_1) { create(:task, category: category_1) }
    let!(:task_2) { create(:task, category: category_2) }

    before do
      login_as(user_1)
    end

    context 'ログイン中のユーザに紐づくタスクにアクセスしたとき' do
      it '成功する' do
        visit task_path(task_1)
        expect(page).to have_content('task_1')
        expect(page).not_to have_content('アクセス権限がありません')
      end
    end
  end
end
