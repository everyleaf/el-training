require 'rails_helper'

RSpec.describe Task, type: :model do
  context 'name is not blank' do
    it 'should be success' do
      t = Task.new(name: 'hoge', description: '')
      expect(t).to be_valid
    end
  end

  context 'name is blank' do
    it 'should be failure' do
      t = Task.new
      t.valid?
      expect(t.errors.full_messages).to eq ['名前を入力してください']
    end
  end
end
