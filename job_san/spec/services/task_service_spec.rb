# frozen_string_literal: true

require 'rails_helper'

RSpec.describe TaskService, type: :model do
  describe '#update_task' do
    let!(:sample_task) { create(:task, status: sample_task_status) }
    let(:sample_task_status) { 'todo' }
    let(:update_status) { 'doing' }
    let(:update_param) { { task: { status: update_status } } }

    it 'should update the task' do
      service = TaskService.new(sample_task)
      expect { service.update_task(update_param) }.to change {
        sample_task.reload
        sample_task.status
      }.from(sample_task_status).to(update_status)
    end

    context 'when got unexpected status param' do
      let(:update_status) { 'wrong_status' }

      it 'should not be updated' do
        service = TaskService.new(sample_task)
        expect { service.update_task(update_param) }.to raise_error(TaskService::TransferStatusError)
      end
    end
  end
end
