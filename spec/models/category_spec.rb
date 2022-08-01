require 'rails_helper'

RSpec.describe Category, type: :model do
  describe 'カテゴリモデルのバリデーションテスト' do
    context 'nameが空のとき' do
      let(:category) { build(:category, name: '') }
      it 'カテゴリは無効である' do
        expect(category).to be_valid
      end
    end
  end
end
