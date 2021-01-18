# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'string "name", limit: 10, null: false' do
    let(:user) { FactoryBot.build_stubbed(:user, name: name) }

    context '0文字の場合' do
      let(:name) { 'a' * 0 }
      it 'バリデーションを通過しないこと' do
        expect(user).to_not be_valid
        expect(user.errors.full_messages).to match_array('ユーザー名が空です')
      end
    end
    context '1文字の場合' do
      let(:name) { 'a' * 1 }
      it 'バリデーションを通過すること' do
        expect(user).to be_valid
      end
    end
    context '10文字の場合' do
      let(:name) { 'a' * 10 }
      it 'バリデーションを通過すること' do
        expect(user).to be_valid
      end
    end
    context '11文字の場合' do
      let(:name) { 'a' * 11 }
      it 'バリデーションを通過しないこと' do
        expect(user).to_not be_valid
        expect(user.errors.full_messages).to match_array('ユーザー名は10文字以内で入力してください')
      end
    end
  end

  describe 'string "email", limit: 30, null: false' do
    let(:user1) { FactoryBot.build_stubbed(:user, name: 'Taro', email: 'aaa@example.com') }
    let(:user2) { FactoryBot.build_stubbed(:user, name: 'Jiro') }

    context '0文字の場合' do
      let(:name) { 'a' * 0 }
      it 'バリデーションを通過しないこと' do
        expect(user).to_not be_valid
        expect(user.errors.full_messages).to match_array('ユーザー名が空です')
      end
    end
    context '1文字の場合' do
      let(:name) { 'a' * 1 }
      it 'バリデーションを通過すること' do
        expect(user).to be_valid
      end
    end
    context '10文字の場合' do
      let(:name) { 'a' * 10 }
      it 'バリデーションを通過すること' do
        expect(user).to be_valid
      end
    end
    context '11文字の場合' do
      let(:name) { 'a' * 11 }
      it 'バリデーションを通過しないこと' do
        expect(user).to_not be_valid
        expect(user.errors.full_messages).to match_array('ユーザー名は10文字以内で入力してください')
      end
    end
  end

  describe 'string "password_digest", null: false' do
    let(:user) { FactoryBot.build_stubbed(:user, password: password, password_confirmation: password_confirmation) }

    context '0文字の場合' do
      let(:password) { 'a' * 0 }
      let(:password_confirmation) { 'a' * 0 }
      it 'バリデーションを通過しないこと' do
        expect(user).to_not be_valid
        expect(user.errors.full_messages).to match_array('パスワードが空です')
      end
    end
    context '再確認用のパスワードと一致しない場合' do
      let(:password) { 'a' * 10 }
      let(:password_confirmation) { 'b' * 10 }
      it 'バリデーションを通過しないこと' do
        expect(user).to_not be_valid
        expect(user.errors.full_messages).to match_array('パスワード（確認）とパスワードの入力が一致しません')
      end
    end
    context '再確認用のパスワードと一致する場合' do
      let(:password) { 'a' * 10 }
      let(:password_confirmation) { 'a' * 10 }
      it 'バリデーションを通過すること' do
        expect(user).to be_valid
      end
    end
  end
end
