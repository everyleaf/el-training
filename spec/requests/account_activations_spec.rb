require 'rails_helper'

RSpec.describe 'AccountActivations', type: :request do
  describe 'POST /users #create' do
    before do
      ActionMailer::Base.deliveries.clear
    end

    let(:user_params) {
      { user: { name: 'test user',
                email: 'test_user@example.com',
                password: 'password',
                password_confirmation: 'password' } }
    }

    context 'ユーザ情報をPOSTしたとき' do
      it 'メールが送信される' do
        expect {
          post users_path, params: user_params                   # ユーザ情報をPOSTすると
        }.to change { ActionMailer::Base.deliveries.size }.by(1) # メールが1件送信される
      end

      it 'ユーザはまだactivateされていない' do
        post users_path, params: user_params
        expect(User.last).not_to be_activated
      end
    end

    context 'activationリンクにアクセスしたとき' do
      before do
        post users_path params: user_params
      end

      let!(:user) { controller.instance_variable_get('@user') }

      it 'ユーザは有効化される' do
        # まだ有効化されていないことを確認
        expect(user).not_to be_activated

        # activationリンクにアクセスし、
        get edit_account_activation_url(user.activation_token, email: user.email)
        # @userを再読み込みすると、
        user.reload
        # ユーザが有効化されている
        expect(user).to be_activated
      end
    end
  end
end
