require 'rails_helper'

RSpec.describe Task, type: :model do
  describe 'validation test' do
    context 'title column' do
      it 'success' do
        t = Task.new(
          title: 'ThisIsTitle',
          description: 'ThisIsDescription'
        )
        expect(t).to be_valid
      end

      it 'failed when it is blank' do
        t = Task.new(
          title: '',
          description: 'ThisIsDescription'
        )
        t.valid?
        expect(t.errors[:title]).to include("can't be blank")
      end

      it 'failed when it is too long' do
        t = Task.new(
          title: SecureRandom.alphanumeric(51),
          description: 'ThisIsDescription'
        )
        t.valid?
        expect(t.errors[:title]).to include('is too long (maximum is 50 characters)')
      end
    end

    context 'description column' do
      it 'success. blank is allowed' do
        t = Task.new(
          title: 'ThisIsTitle',
          description: ''
        )
        expect(t).to be_valid
      end

      it 'failed when it is too long' do
        t = Task.new(
          title: 'ThisIsTitle',
          description: SecureRandom.alphanumeric(501),
        )
        t.valid?
        expect(t.errors[:description]).to include('is too long (maximum is 500 characters)')
      end
    end
  end
end
