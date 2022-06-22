require 'rails_helper'

RSpec.describe Task, type: :model do
  describe 'モデルのバリデーションテスト' do

    context '全てのパラメータが要素を持つとき' do
      let(:task){ build(:task) }
      it 'タスクは有効である' do
        expect(task).to be_valid
      end
    end

    context 'descriptionのみがnilのとき' do
      let(:task) { build(:task, description: nil) }
      it 'タスクは有効である' do
        expect(task).to be_valid
      end
    end

    context 'nameがnilのとき' do
      let(:task) { build(:task, name: nil) }
      it 'タスクは無効である' do
        expect(task).to be_invalid
      end
    end

    context 'necessary_daysが0のとき' do
      let(:task) { build(:task, necessary_days: 0) }
      it 'タスクは無効である' do
        expect(task).to be_invalid
      end
    end

    context 'necessary_daysが負の数のとき' do
      let(:task) { build(:task, necessary_days: -1) }
      it 'タスクは無効である' do
        expect(task).to be_invalid
      end
    end
  end
end
