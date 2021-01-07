# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Task, type: :model do
  shared_examples 'バリデーションを通過すること' do
    it { expect(task).to be_valid }
  end
  
  shared_examples '期待したバリデーションエラーメッセージが表示されること' do
    it do
      task.valid?
      expect(task.errors.full_messages).to match_array(message)
    end
  end

  describe 'title (NotNull, maximum:50)' do
    let(:task) { FactoryBot.build(:task, title: title) }

    context '0文字の場合' do
      let(:title) { 'a' * 0 }
      let(:message) { 'タスク名が空になっています' }
      it_behaves_like '期待したバリデーションエラーメッセージが表示されること'
    end
    context '10文字の場合' do
      let(:title) { 'a' * 10 }
      it_behaves_like 'バリデーションを通過すること'
    end
    context '50文字の場合' do
      let(:title) { 'a' * 50 }
      it_behaves_like 'バリデーションを通過すること'
    end
    context '51文字の場合' do
      let(:title) { 'a' * 51 }
      let(:message) { 'タスク名は50文字以内で入力してください' }
      it_behaves_like '期待したバリデーションエラーメッセージが表示されること'
    end
  end

  describe 'detail (maximum:200)' do
    let(:task) { FactoryBot.build(:task, detail: detail) }

    context '0文字の場合' do
      let(:detail) { 'a' * 0 }
      it_behaves_like 'バリデーションを通過すること'
    end
    context '10文字の場合' do
      let(:detail) { 'a' * 10 }
      it_behaves_like 'バリデーションを通過すること'
    end
    context '200文字の場合' do
      let(:detail) { 'a' * 200 }
      it_behaves_like 'バリデーションを通過すること'
    end
    context '201文字の場合' do
      let(:detail) { 'a' * 201 }
      let(:message) { '詳細は200文字以内で入力してください' }
      it_behaves_like '期待したバリデーションエラーメッセージが表示されること'
    end
  end
end
