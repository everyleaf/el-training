# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Label, type: :model do
  describe '#destroy' do
    context 'when label related with some tasks' do
      let!(:label) { create(:label) }
      let(:related_record_count) { 3 }
      before do
        tasks = create_list(:task, related_record_count)
        label.tasks << tasks
      end

      it 'delete label with its relation records' do
        expect {
          label.destroy
        }.to change {
          Label.count
        }.by(-1).and change {
          Label::TaskLabelRelation.count
        }.by(-related_record_count).and change {
          Task.count
        }.by(0)
      end
    end
  end
end
