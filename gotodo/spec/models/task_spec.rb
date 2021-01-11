# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Task, type: :model do
  describe 'string "title", limit: 50, null: false' do
    let(:task) { FactoryBot.build_stubbed(:task, title: title) }

    context '0文字の場合' do
      let(:title) { 'a' * 0 }
      it 'バリデーションを通過しないこと' do
        expect(task).to_not be_valid
        expect(task.errors.full_messages).to match_array('タスク名が空になっています')
      end
    end
    context '10文字の場合' do
      let(:title) { 'a' * 10 }
      it 'バリデーションを通過すること' do
        expect(task).to be_valid
      end
    end
    context '50文字の場合' do
      let(:title) { 'a' * 50 }
      it 'バリデーションを通過すること' do
        expect(task).to be_valid
      end
    end
    context '51文字の場合' do
      let(:title) { 'a' * 51 }
      it 'バリデーションを通過しないこと' do
        expect(task).to_not be_valid
        expect(task.errors.full_messages).to match_array('タスク名は50文字以内で入力してください')
      end
    end
  end

  describe 'string "detail", limit: 200' do
    let(:task) { FactoryBot.build_stubbed(:task, detail: detail) }

    context '0文字の場合' do
      let(:detail) { 'a' * 0 }
      it 'バリデーションを通過すること' do
        expect(task).to be_valid
      end
    end
    context '10文字の場合' do
      let(:detail) { 'a' * 10 }
      it 'バリデーションを通過すること' do
        expect(task).to be_valid
      end
    end
    context '200文字の場合' do
      let(:detail) { 'a' * 200 }
      it 'バリデーションを通過すること' do
        expect(task).to be_valid
      end
    end
    context '201文字の場合' do
      let(:detail) { 'a' * 201 }
      it 'バリデーションを通過しないこと' do
        expect(task).to_not be_valid
        expect(task.errors.full_messages).to match_array('詳細は200文字以内で入力してください')
      end
    end
  end

  describe '検索機能' do
    let!(:task1) { FactoryBot.create(:task, title: '買い物に行く', status: 'done') }
    let!(:task2) { FactoryBot.create(:task, title: '料理をする', status: 'doing') }
    let!(:task3) { FactoryBot.create(:task, title: '食べる', status: 'todo') }
    let!(:task4) { FactoryBot.create(:task, title: '美容院に行く', status: 'done') }
    # 【メモ】 enum status: { todo: 0, doing: 5, done: 9 }

    describe 'title' do
      subject { Task.task_search(title: '料理') }
      it '検索条件を含むタスクが表示され、含まないタスクは表示されないこと' do
        is_expected.to include(task2)
        is_expected.to_not include(task1)
        is_expected.to_not include(task3)
        is_expected.to_not include(task4)
      end
    end

    describe 'status' do
      subject { Task.task_search(status: 'done') }
      it '検索条件を含むタスクが表示され、含まないタスクは表示されないこと' do
        is_expected.to include(task1)
        is_expected.to include(task4)
        is_expected.to_not include(task2)
        is_expected.to_not include(task3)
      end
    end
  end
end
