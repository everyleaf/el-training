require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'ユーザモデルのバリデーションテスト' do
    context 'nameが空のとき' do
      let(:user) { build(:user, name: '') }
      it 'ユーザは無効である' do
        expect(user).not_to be_valid
      end
    end

    context 'メールアドレスがすでに存在するとき' do
      let!(:user) { create(:user, email: 'test@example.com') }
      it 'ユーザは無効である' do
        another_user = build(:user)
        another_user.email = user.email
        expect(another_user).not_to be_valid
      end
    end

    context 'メールアドレスが無効なとき' do
      it 'ユーザは無効である' do
        invalid_addresses = %w(test
                               test@example,com
                               test@example
                               test@@example
                               test@@example+com)
        invalid_addresses.each do |email|
          user = build(:user, email:)
          expect(user).not_to be_valid
        end
      end
    end

    context 'パスワードが8文字未満のとき' do
      let(:user) { build(:user,password: "a"*7,password_confirmation: "a"*7 ) }
      it 'ユーザは無効である' do
        expect(user).not_to be_valid
      end
    end

    context 'パスワードが8文字以上のとき' do
      let(:user) { build(:user,password: "a"*8,password_confirmation: "a"*8 ) }
      it 'ユーザは無効である' do
        expect(user).to be_valid
      end
    end
  end
end
