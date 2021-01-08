# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Task, type: :model do
  describe 'create a task' do
    let!(:sample_user) { create(:user) }

    context 'when name is blank' do
      let(:sample_description) { SecureRandom.rand(10) }

      it 'should not create a new task' do
        task = Task.new(description: sample_description, user: sample_user)
        expect(task.save).to be_falsey
        expect(task.errors.full_messages).to eq(['タスク名を入力してください'])
      end
    end

    context 'when value size is too long' do
      let(:over_size_name) { (0..255).map { |_| '🥺️' }.join }

      it 'should not create a new task' do
        task = Task.new(name: over_size_name, description: over_size_name, user: sample_user)
        expect(task.save).to be_falsey
        messages = { 'タスク名' => 255, '説明文' => 255 }.map do |column, limit|
          "#{column}は#{limit}文字以内で入力してください"
        end
        expect(task.errors.full_messages).to match_array(messages)
      end
    end
  end

  describe '#update' do
    let(:sample_name) { SecureRandom.rand(10) }
    let!(:sample_task) { create(:task, name: sample_name) }
    let(:status_todo) { 'todo' }
    let(:status_doing) { 'doing' }
    let(:status_done) { 'done' }

    context '#turn_back' do
      let!(:sample_task) { create(:task, status: status_doing) }

      it 'update task status' do
        expect { sample_task.turn_back }.to change { sample_task.status }.from(status_doing).to(status_todo)
      end
    end

    context '#start' do
      let!(:sample_task) { create(:task, status: status_todo) }

      it 'update task status' do
        expect { sample_task.start }.to change { sample_task.status }.from(status_todo).to(status_doing)
      end
    end

    context '#finish' do
      let!(:sample_task) { create(:task, status: status_todo) }

      it 'update task status' do
        expect { sample_task.finish }.to change { sample_task.status }.from(status_todo).to(status_done)
      end
    end

    context 'when name is blank' do
      it 'should not update the task' do
        expect(sample_task.update(name: '')).to be_falsey
        expect(sample_task.errors.full_messages).to eq(['タスク名を入力してください'])
      end
    end

    context 'when value size is too long' do
      let(:over_size_name) { (0..255).map { |_| '🥺️' }.join }

      it 'should not update the task' do
        expect(sample_task.update(name: over_size_name, description: over_size_name)).to be_falsey
        messages = { 'タスク名' => 255, '説明文' => 255 }.map do |column, limit|
          "#{column}は#{limit}文字以内で入力してください"
        end
        expect(sample_task.errors.full_messages).to match_array(messages)
      end
    end
  end
end
