require 'rails_helper'

RSpec.describe Todo, type: :model do
  describe 'validation' do
    describe 'title' do
      context 'is nil' do
        it "can't be created" do
          expect{ create(:todo, title: '') }.to raise_error(ActiveRecord::RecordInvalid)
        end
      end
      context 'is not nil' do
        it 'can be created' do
          expect{ create(:todo) }.not_to raise_error
        end
      end
    end
  end
    
end
