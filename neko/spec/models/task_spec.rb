require 'rails_helper'

RSpec.describe Task, type: :model do
  let!(:status) { FactoryBot.create(:not_proceed) }
  context 'name is not blank' do
    it 'should be success' do
      t = Task.new(name: 'hoge', description: '', status: status)
      expect(t).to be_valid
    end
  end

  context 'name is blank' do
    it 'should be failure' do
      t = Task.new(name: '', description: '', status: status)
      t.valid?
      expect(t.errors.full_messages).to eq ['名前を入力してください']
    end
  end

  context 'statu_id is null' do
    it 'should be failure' do
      t = Task.new(name: 'hoge', description: '')
      t.valid?
      expect(t.errors.full_messages).to eq ['Statusを入力してください']
    end
  end
end
