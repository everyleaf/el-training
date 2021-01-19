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

  describe 'string "email", limit: 30, null: false, unique: true' do
    let(:user1) { FactoryBot.create(:user, name: 'Taro', email: 'taro@example.com') }
    let(:user2) { FactoryBot.build_stubbed(:user, name: 'Jiro', email: email) }

    context 'メールアドレス形式の場合' do
      context '30文字の場合' do
        let(:email) { 'a' * 18 + '@example.com' }
        it 'バリデーションを通過すること' do
          expect(user2).to be_valid
        end
      end
      context '31文字の場合' do
        let(:email) { 'a' * 19 + '@example.com' }
        it 'バリデーションを通過しないこと' do
          expect(user2).to_not be_valid
          expect(user2.errors.full_messages).to match_array('メールアドレスは30文字以内で入力してください')
        end
      end
      context '登録済みのメールアドレスの場合' do
        let(:email) { user1.email }
        it 'バリデーションを通過しないこと' do
          expect(user2).to_not be_valid
          expect(user2.errors.full_messages).to match_array('メールアドレスはすでに存在します')
        end
      end
    end
    context 'メールアドレス形式でない場合' do
      context '0文字の場合' do
        let(:email) { 'a' * 0 }
        it 'バリデーションを通過しないこと' do
          expect(user2).to_not be_valid
          expect(user2.errors.full_messages).to match_array(%w[メールアドレスの形式が不正です メールアドレスを入力してください])
        end
      end
      context '30文字の場合' do
        let(:email) { 'a' * 30 }
        it 'バリデーションを通過しないこと' do
          expect(user2).to_not be_valid
          expect(user2.errors.full_messages).to match_array('メールアドレスの形式が不正です')
        end
      end
      context '31文字の場合' do
        let(:email) { 'a' * 31 }
        it 'バリデーションを通過しないこと' do
          expect(user2).to_not be_valid
          expect(user2.errors.full_messages).to match_array(%w[メールアドレスの形式が不正です メールアドレスは30文字以内で入力してください])
        end
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
