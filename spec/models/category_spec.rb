require 'rails_helper'

RSpec.describe Category, type: :model do
  describe 'モデルのバリデーションテスト' do
    context 'nameが空のとき' do
      let(:category) { build(:category, name: '') }
      it 'カテゴリは無効である' do
        expect(task).to be_valid
      end
    end
  end
end
