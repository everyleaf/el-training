require 'rails_helper'

RSpec.describe Category, type: :model do
  describe 'カテゴリモデルのバリデーションテスト' do
    context 'nameが空のとき' do
      let(:category) { build(:category, name: '') }
      it 'カテゴリは無効である' do
        expect(category).not_to be_valid
      end
    end

    context '単一ユーザ内で同じ名前のカテゴリが作られたとき' do
      let!(:user) { create(:user) }
      let!(:category) { create(:category, name: 'cat_1', user_id: user.id) }
      it 'カテゴリは無効である' do
        another_category = build(:category, user_id: user.id)
        another_category.name = category.name
        expect(another_category).not_to be_valid
      end
    end

    context '異なるユーザ間で同じ名前のカテゴリが作られたとき' do
      let!(:user1) { create(:user, email: 'user1@example.com') }
      let!(:user2) { create(:user, email: 'user2@example.com') }
      let!(:category) { create(:category, name: 'category', user: user1) }
      it 'どちらも有効である' do
        another_category = build(:category, name: category.name, user: user2)
        expect(another_category).to be_valid
      end
    end
  end
end
