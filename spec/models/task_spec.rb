require 'rails_helper'

RSpec.describe Task, type: :model do

  context '全ての項目が記入されていれば' do
    let(:task){ build(:task) }
    it 'タスクは有効' do
      expect(task).to be_valid
    end
  end

  context 'descriptionが空でも' do
    let(:task){ build(:task, description: nil) }
    it 'タスクは有効' do
      expect(task).to be_valid
    end
  end

  context 'nameが空だと' do
    let(:task){ build(:task, name: nil) }
    it 'タスクは無効' do
      expect(task).to be_invalid
    end
  end

  context 'necessary_daysが0だと' do
    let(:task){ build(:task, necessary_days: 0) }
    it 'タスクは無効' do
      expect(task).to be_invalid
    end
  end

  context 'necessary_daysが負の数だと' do
    let(:task){ build(:task, necessary_days: -1) }
    it 'タスクは無効' do
      expect(task).to be_invalid
    end
  end
end
