require 'rails_helper'

RSpec.describe Task, type: :model do
  let!(:not_proceed) { FactoryBot.create(:not_proceed) }
  let!(:in_progress) { FactoryBot.create(:in_progress) }
  let!(:done) { FactoryBot.create(:done) }
  let!(:task1) { create(:task, name: 'task1', status: not_proceed) }
  let!(:task2) { create(:task, name: 'task2', status: in_progress) }
  let!(:task3) { create(:task, name: 'task3', status: done) }
  let!(:task4) { create(:task, name: 'task4', status: in_progress) }
  let!(:taskA) { create(:task, name: 'タスクA', status: not_proceed) }
  let!(:taskB) { create(:task, name: 'タスクB', status: done) }

  context 'name is not blank' do
    it 'should be success' do
      task = Task.new(name: 'hoge', description: '', status: in_progress)
      expect(task).to be_valid
    end
  end

  context 'name is blank' do
    it 'should be failure' do
      task = Task.new(name: '', description: '', status: in_progress)
      task.valid?
      expect(t.errors.full_messages).to eq ['名前を入力してください']
    end
  end

  context 'statu_id is null' do
    it 'should be failure' do
      task = Task.new(name: 'hoge', description: '')
      task.valid?
      expect(t.errors.full_messages).to eq ['ステータスを入力してください']
    end
  end

  context 'search function' do
    it 'search tasks by name & status' do
      test_cases = [
        { name: 'task', status_id: in_progress.id },
        { name: 'タスク', status_id: nil },
        { name: '', status_id: done.id },
        { name: '', status_id: nil }
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
