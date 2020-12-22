# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Task, type: :model do
  describe 'create a task' do
    context 'when name is blank' do
      let(:sample_description) { SecureRandom.rand(10) }

      it 'should not create a new task' do
        task = Task.new(description: sample_description)
        task.save
        expect(task.save).to be_falsey
        expect(task.errors.full_messages).to eq(['タスク名は１文字以上入力してください。'])
      end
    end
  end

  describe '#update' do
    context 'when name is blank' do
      let(:sample_description) { SecureRandom.rand(10) }
      let!(:sample_task) { create(:task) }

      it 'should not update the task' do
        expect(sample_task.update(name: '')).to be_falsey
        expect(sample_task.errors.full_messages).to eq(['タスク名は１文字以上入力してください。'])
      end
    end
  end
end
