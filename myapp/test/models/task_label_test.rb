# == Schema Information
#
# Table name: task_labels
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  label_id   :integer          not null
#  task_id    :integer          not null
#
# Indexes
#
#  index_task_labels_on_label_id  (label_id)
#  index_task_labels_on_task_id   (task_id)
#
require "test_helper"

class TaskLabelTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
