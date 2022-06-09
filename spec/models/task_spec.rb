require 'rails_helper'

RSpec.describe Task, type: :model do
  it 'すべての項目が記入されていれば有効' do
    task = build(:task)
    expect(task).to be_valid
  end

  it 'descriptionが空でも有効' do
    task = build(:task, description: nil)
    expect(task).to be_valid
  end

  it 'nameが空だと無効' do
    task = build(:task, name: nil)
    expect(task).to be_invalid
  end

  it 'necessary_daysが0だと無効' do
    task = build(:task, necessary_days: 0)
    expect(task).to be_invalid
  end

  it 'necessary_daysが負の数だと無効' do
    task = build(:task, necessary_days: -1)
    expect(task).to be_invalid
  end
end
