RSpec.describe 'User Authorization before Task_CRUD', type: :request do
  describe 'タスクCRUDの認可' do
    let!(:user1) { create(:user, email: 'user_1@example.com') }
    let!(:user2) { create(:user, email: 'user_2@example.com') }
    let!(:task1) { create(:task, category: create(:category, user: user1)) }
    let!(:task2) { create(:task, category: create(:category, user: user2)) }

    before do
      session_params = { session: { email: user1.email, password: user1.password } }
      post '/login', params: session_params
    end

    context 'ログインユーザのタスクにアクセスしたとき' do
      it '成功する' do
        get task_path(task1)
        expect(response.body).to include(task1.name)
        expect(response.body).not_to include('アクセス権限がありません')
      end
    end

    context 'ログインユーザ以外のタスクにアクセスしたとき' do
      it '失敗する' do
        get task_path(task2)
        expect(response.body).not_to include(task2.name)
        expect(response).to redirect_to root_url
      end
    end
  end
end
