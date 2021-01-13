# frozen_string_literal: true

require 'rails_helper'

RSpec.describe TaskService, type: :model do
  describe '#create_task' do
    let!(:sample_labels) { create_list(:label, 2) }
    let(:sample_task_name) { 'タスク名' }
    let(:sample_task_status) { 'todo' }
    let(:create_param) { { name: sample_task_name, status: sample_task_status, attach_labels: sample_labels.map(&:id) } }
    let!(:login_user) { create(:user) }

    it 'should create a task' do
      task = login_user.tasks.new(create_param.except(:attach_labels))
      service = TaskService.new(task)
      expect { service.create_task(create_param) }.to change {
        Task.count
      }.by(1).and change {
        Task::TaskLabelRelation.count
      }.by(sample_labels.count)

      created_tasks = Task.find_by(name: sample_task_name, status: sample_task_status)
      expect(created_tasks.labels.map(&:id)).to eq(sample_labels.map(&:id))
    end
  end

  describe '#update_task' do
    let!(:sample_task) { create(:task, name: sample_task_name, status: sample_task_status) }
    let!(:update_labels) { create_list(:label, 2) }
    let(:sample_task_name) { 'タスク名' }
    let(:sample_task_status) { 'todo' }
    let(:update_name) { '更新するタスク名' }
    let(:update_status) { 'doing' }
    let(:update_param) { { name: update_name, status: update_status, attach_labels: update_labels.map(&:id) } }

    it 'should update the task' do
      service = TaskService.new(sample_task)
      expect { service.update_task(update_param) }.to change {
        sample_task.reload
        sample_task.status
      }.from(sample_task_status).to(update_status)
       .and change {
         sample_task.name
       }.from(sample_task_name).to(update_name)
        .and change {
          sample_task.labels.count
        }.by(update_labels.count)
    end

    context 'when update labels' do
      let(:sample_labels) { create_list(:label, 3) }
      before { sample_task.labels << sample_labels }

      it 'update relation of task and labels' do
        service = TaskService.new(sample_task)
        expect { service.update_task(update_param) }.to change {
          sample_task.reload
          sample_task.labels.map(&:id)
        }.from(sample_labels.map(&:id)).to(update_labels.map(&:id))
      end
    end

    context 'when got unexpected status param' do
      let(:update_status) { 'wrong_status' }

      it 'should not be updated' do
        service = TaskService.new(sample_task)
        expect(service.update_task(update_param).errors.full_messages).to eq(['ステータスは不正な値です'])
      end
    end
  end
end
