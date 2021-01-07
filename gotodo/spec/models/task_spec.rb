# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Task, type: :model do
  shared_examples 'バリデーションを通過すること' do
    it { is_expected.to be_valid }
  end
  shared_examples 'バリデーションを通過しないこと' do
    it { is_expected.to be_invalid }
  end

  describe 'title (NotNull, maximum:50)' do
    subject(:task) { FactoryBot.build(:task, title: title) }

    context '0文字の場合' do
      let(:title) { 'a' * 0 }
      it_behaves_like 'バリデーションを通過しないこと'
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
      it_behaves_like 'バリデーションを通過しないこと'
    end
  end

  describe 'detail (maximum:200)' do
    subject(:task) { FactoryBot.build(:task, detail: detail) }

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
      it_behaves_like 'バリデーションを通過しないこと'
    end
  end
end
