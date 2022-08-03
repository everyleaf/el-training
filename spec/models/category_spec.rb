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
      let!(:category) { create(:category, name: 'cat_1') }
      it 'カテゴリは無効である' do
        another_category = build(:category)
        another_category.name = category.name
        expect(another_category).not_to be_valid
      end
    end
  end
end
