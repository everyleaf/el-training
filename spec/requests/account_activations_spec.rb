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
        # メールが0件なことを確認
        expect(ActionMailer::Base.deliveries.size).to eq 0

        # ユーザ情報をPOSTすると
        post users_path, params: user_params
        # メールが1件送信される
        expect(ActionMailer::Base.deliveries.size).to eq 1
      end

      it 'ユーザはまだactivateされていない' do
        post users_path, params: user_params
        expect(User.last).not_to be_activated
      end
    end

    context 'activationリンクにアクセスしたとき' do
      before do
        post users_path params: user_params
        @user = controller.instance_variable_get('@user')
      end

      it 'ユーザは有効化される' do
        # まだ有効化されていないことを確認
        expect(@user).not_to be_activated

        # activationリンクにアクセスし、
        get edit_account_activation_url(@user.activation_token, email: @user.email)
        # @userを再読み込みすると、
        @user.reload
        # ユーザが有効化されている
        expect(@user).to be_activated
      end
    end
  end
end
