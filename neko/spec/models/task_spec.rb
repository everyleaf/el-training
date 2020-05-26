require 'rails_helper'

RSpec.describe Task, type: :model do
  let!(:task1) { create(:task, name: 'task1', status: 0) }
  let!(:task2) { create(:task, name: 'task2', status: 1) }
  let!(:task3) { create(:task, name: 'task3', status: 2) }
  let!(:task4) { create(:task, name: 'task4', status: 1) }
  let!(:taskA) { create(:task, name: 'タスクA', status: 0) }
  let!(:taskB) { create(:task, name: 'タスクB', status: 2) }

  context 'name is not blank' do
    it 'should be success' do
      task = Task.new(name: 'hoge', description: '', status: 1)
      expect(task).to be_valid
    end
  end

  context 'name is blank' do
    it 'should be failure' do
      task = Task.new(name: '', description: '', status: 1)
      task.valid?
      expect(task.errors.full_messages).to eq ['名前を入力してください']
    end
  end

  context 'search function' do
    it 'search tasks by name & status' do
      test_cases = [
        { name: 'task', status: 1 },
        { name: 'タスク', status: nil },
        { name: '', status: 2 },
        { name: '', status: nil }
      ]

      outputs = [
        [task2, task4],
        [taskA, taskB],
        [task3, taskB],
        [task1, task2, task3, task4, taskA, taskB]
      ]

      test_cases.each_with_index do |test_case, i|
        expect(Task.search(test_case)).to eq outputs[i]
      end
    end
  end
end
