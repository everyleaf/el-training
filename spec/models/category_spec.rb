require 'rails_helper'

RSpec.describe Category, type: :model do
  describe 'カテゴリモデルのバリデーションテスト' do
    context 'nameが空のとき' do
      let(:category) { build(:category, name: '') }
      it 'カテゴリは無効である' do
        expect(category).not_to be_valid
      end
    end

    context 'カテゴリ名はユニーク' do
      let!(:user) { create(:user) }
      let!(:category) { create(:category, name: 'cat_1', user_id: user.id) }
      it 'カテゴリは無効である' do
        another_category = build(:category, user_id: user.id)
        another_category.name = category.name
        expect(another_category).not_to be_valid
      end
    end
  end
end
