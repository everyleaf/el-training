# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Task, type: :model do
  describe 'title (maximum:50)' do
    subject(:task) { FactoryBot.build(:task, title: title) }

    shared_examples 'バリデーションを通過する' do
      it { is_expected.to be_valid }
    end
    shared_examples 'バリデーションを通過しない' do
      it { is_expected.to be_invalid }
    end

    context '0文字の場合' do
      let(:title) { 'a' * 0 }
      it_behaves_like 'バリデーションを通過しない'
    end
    context '10文字の場合' do
      let(:title) { 'a' * 10 }
      it_behaves_like 'バリデーションを通過する'
    end
    context '50文字の場合' do
      let(:title) { 'a' * 50 }
      it_behaves_like 'バリデーションを通過する'
    end
    context '51文字の場合' do
      let(:title) { 'a' * 51 }
      it_behaves_like 'バリデーションを通過しない'
    end
  end
end
