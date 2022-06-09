require 'rails_helper'

RSpec.describe Task, type: :model do

before do
  task = Task.new(
    name:           'test task',
    description:    'this is a test task',
    start_date:     Date.today,
    necessary_days: 3,
    progress:       '未着手',
    priority:       '低'
  )
end

  it "すべての項目が記入されていれば有効" do
    expect(task).to be_truthy
  end

  it "descriptionが空でも有効" do
    task.description = nil
    expect(task).to be_truthy
  end

  it "nameが空だと無効" do
    task.name = nil
    expect(task).to be_falsey
  end

  it "necessary_daysが0だと無効" do
    task.necessary_days = 0
    expect(task).to be_falsey
  end

  it "necessary_daysが負の数だと無効" do
    task.necessary_days = -1
    expect(task).to be_falsey
  end
end
