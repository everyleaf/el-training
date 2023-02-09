# == Schema Information
#
# Table name: labels
#
#  id         :bigint           not null, primary key
#  deleted_at :datetime
#  name       :string(255)      not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_labels_on_name  (name)
#
require 'test_helper'

class LabelTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
