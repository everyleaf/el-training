# == Schema Information
#
# Table name: tasks
#
#  id                                           :bigint           not null, primary key
#  deleted_at                                   :datetime
#  description                                  :text(65535)      not null
#  expires_at                                   :datetime
#  priority({0: "high", 1: "middle", 2: "low"}) :integer          not null
#  status(["waiting", "doing", "completed"])    :integer          not null
#  title                                        :string(255)      not null
#  created_at                                   :datetime         not null
#  updated_at                                   :datetime         not null
#  user_id                                      :bigint           not null
#
# Indexes
#
#  index_tasks_on_user_id                            (user_id)
#  index_tasks_on_user_id_and_expires_at             (user_id,expires_at)
#  index_tasks_on_user_id_and_priority               (user_id,priority)
#  index_tasks_on_user_id_and_status                 (user_id,status)
#  index_tasks_on_user_id_and_status_and_expires_at  (user_id,status,expires_at)
#  index_tasks_on_user_id_and_status_and_priority    (user_id,status,priority)
#  index_tasks_on_user_id_and_title                  (user_id,title)
#
require 'rails_helper'

RSpec.describe Task, type: :model do
  let!(:user) { create(:user) }
  describe 'enums' do
    it  {
      is_expected.to define_enum_for(:priority).with_values(
        high: 0,
        middle: 1,
        low: 2
      )
    }

    it {
      is_expected.to define_enum_for(:status).with_values(
        waiting: 0,
        doing: 1,
        completed: 2
      )
    }
  end

  describe 'sort_by_keyword' do
    let!(:first_task) { create(:task, title: 'a', description: 'aaa', priority: 'low', status: 'waiting', user_id: user.id, expires_at: '2023/01/03 00:00') }
    let!(:second_task) { create(:task, title: 'b', description: 'bbb', priority: 'middle', status: 'doing', user_id: user.id, expires_at: '2023/01/02 00:00') }
    let!(:third_task) { create(:task, title: 'c', description: 'ccc', priority: 'high', status: 'completed', user_id: user.id, expires_at: '2023/01/01 00:00') }

    subject { Task.sort_by_keyword(sort) }

    context "When argument 'sort' is created_at_asc" do
      let(:sort) { 'created_at_asc' }

      it 'sort by specified sort type' do
        is_expected.to eq [first_task, second_task, third_task]
      end
    end

    context "When argument 'sort' is created_at_desc" do
      let(:sort) { 'created_at_desc' }

      it 'sort by specified sort type' do
        is_expected.to eq [third_task, second_task, first_task]
      end
    end

    context "When argument 'sort' is expires_at_asc" do
      let(:sort) { 'expires_at_asc' }

      it 'sort by specified sort type' do
        is_expected.to eq [third_task, second_task, first_task]
      end
    end

    context "When argument 'sort' is expires_at_desc" do
      let(:sort) { 'expires_at_desc' }

      it 'sort by specified sort type' do
        is_expected.to eq [first_task, second_task, third_task]
      end
    end
  end
  describe 'search_by_status' do
    let!(:first_task) { create(:task, title: 'a', description: 'aaa', priority: 'low', status: 'waiting', user_id: user.id, expires_at: '2023/01/03 00:00') }
    let!(:second_task) { create(:task, title: 'b', description: 'bbb', priority: 'middle', status: 'waiting', user_id: user.id, expires_at: '2023/01/02 00:00') }
    let!(:third_task) { create(:task, title: 'c', description: 'ccc', priority: 'high', status: 'completed', user_id: user.id, expires_at: '2023/01/01 00:00') }

    subject { Task.search_by_status(status) }
    context "When 'waiting' tasks counts 2 " do
      let(:status) { 'waiting' }
      it 'expects 2 records return' do
        is_expected.to eq [first_task, second_task]
        is_expected.to change(Task, :count).to(2)
      end
    end
  end
end

