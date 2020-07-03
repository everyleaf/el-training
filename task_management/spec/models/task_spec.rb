require 'rails_helper'

RSpec.describe Task, type: :model do
  describe 'バリデーション' do
    describe 'タイトル' do
      subject { task }

      let!(:task) { build(:task, title: title) }

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

    describe '優先度' do
      subject { task }

      let(:task) { build(:task, priority: priority) }

      context '入力が正しい場合' do
        let(:priority) { 0 }

        it { is_expected.to be_valid }
      end

      context '空欄の場合' do
        let(:priority) { '' }

        it { is_expected.to be_invalid }
      end

      context '数値以外の場合' do
        let(:priority) { 'PRIORITY' }

        it { expect { subject }.to raise_error(ArgumentError) }
      end

      context '0~2以外の数値の場合' do
        let(:priority) { 3 }

        it { expect { subject }.to raise_error(ArgumentError) }
      end
    end

    describe 'ステータス' do
      subject { task }

      let(:task) { build(:task, status: status) }

      context '入力が正しい場合' do
        let(:status) { 0 }

        it { is_expected.to be_valid }
      end

      context '空欄の場合' do
        let(:status) { '' }

        it { is_expected.to be_invalid }
      end

      context '数値以外の場合' do
        let(:status) { 'STATUS' }

        it { expect { subject }.to raise_error(ArgumentError) }
      end

      context '0~2以外の数値の場合' do
        let(:status) { '3' }

        it { expect { subject }.to raise_error(ArgumentError) }
      end
    end

    describe '期日' do
      subject { task }

      let!(:task) { build(:task, due: due) }

      context '入力が正しい場合' do
        let(:due) { '2020/07/02' }

        it { is_expected.to be_valid }
      end

      context '空欄の場合' do
        let(:due) { '' }

        it { is_expected.to be_valid }
      end

      context '存在しない日付の場合' do
        let(:due) { '2020/99/99' }

        it { is_expected.to be_invalid }
      end

      context '日付のフォーマットでない文字列の場合' do
        let(:due) { 'AAAAAA' }

        it { is_expected.to be_invalid }
      end
    end
  end
end
