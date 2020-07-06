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

  describe '検索機能' do
    subject { Task.search(search_params) }

    let!(:task1) { create(:task, title: 'task1', status: 0) }
    let!(:task2) { create(:task, title: '2task2', status: 1) }
    let!(:task3) { create(:task, title: '3task', status: 2) }
    let!(:task4) { create(:task, title: 'English', status: 2) }

    context 'タイトルで検索した場合' do
      context 'タイトルを入力して検索した場合' do
        let(:search_params) { { title: 'task' } }

        it '部分一致したタスクが出力される' do
          expect(subject.size).to eq 3
          expect(subject[0]).to eq task1
          expect(subject[1]).to eq task2
          expect(subject[2]).to eq task3
        end
      end

      context 'タイトルを入力せずに検索した場合' do
        let(:search_params) { {} }

        it '全てのタスクが出力される' do
          expect(subject.size).to eq 4
          expect(subject[0]).to eq task1
          expect(subject[1]).to eq task2
          expect(subject[2]).to eq task3
          expect(subject[3]).to eq task4
        end
      end
    end

    context 'ステータスで検索した場合' do
      context 'ステータスを指定した場合' do
        let(:search_params) { { status: 1 } }

        it '着手中のタスクが出力される' do
          expect(subject.size).to eq 1
          expect(subject[0]).to eq task2
        end
      end

      context 'ステータスを指定しない場合' do
        let(:search_params) { {} }

        it '全てのタスクが出力される' do
          expect(subject.size).to eq 4
          expect(subject[0]).to eq task1
          expect(subject[1]).to eq task2
          expect(subject[2]).to eq task3
          expect(subject[3]).to eq task4
        end
      end
    end
  end
end
