# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Task, type: :model do
  describe 'title (NotNull, maximum:50)' do
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

  describe 'detail (maximum:200)' do
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
end
