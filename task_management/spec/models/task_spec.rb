require 'rails_helper'

RSpec.describe Task, type: :model do
  describe 'バリデーション' do
    let!(:task) { build(:task, title: title) }

    subject { task }

    context '入力が正しい場合' do
      let(:title) { 'TASK' }

      it { is_expected.to be_valid }
    end

    context '空欄の場合' do
      let(:title) { '' }

      it { is_expected.to be_invalid }
    end

    context '文字数の最大値の場合' do
      let(:title) { 'a' * 20 }

      it { is_expected.to be_valid }
    end

    context '文字数の最大値を超過した場合' do
      let(:title) { 'a' * 21 }

      it { is_expected.to be_invalid }
    end
  end
end
