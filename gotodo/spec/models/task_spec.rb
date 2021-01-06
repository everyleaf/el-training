# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Task, type: :model do
  describe 'title (NotNull, maximum:50)' do
    subject(:task) { FactoryBot.build(:task, title: title) }

    shared_examples 'バリデーションを通過すること' do
      it { is_expected.to be_valid }
    end
    shared_examples 'バリデーションを通過しないこと' do
      it { is_expected.to be_invalid }
    end

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
end
