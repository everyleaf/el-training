require 'rails_helper'

RSpec.describe Task, type: :model do
  describe 'enums' do
    it {
      is_expected.to define_enum_for(:priority).with_values(
        high: 0,
        middle: 1,
        low: 2
      )
    }
  end
end
