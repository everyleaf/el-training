require 'rails_helper'

RSpec.describe Task, type: :model do
  describe 'validation test' do
    context 'title column' do
      it 'success' do
        t = Task.new(
          title: 'ThisIsTitle',
        )
        expect(t).to be_valid
      end

      it 'failed when it is blank' do
        t = Task.new(
          title: '',
        )
        t.valid?
        expect(t.errors[:title]).to include('を入力してください')
      end

      it 'failed when it is too long' do
        t = Task.new(
          title: SecureRandom.alphanumeric(51),
        )
        t.valid?
        expect(t.errors[:title]).to include('は50文字以内で入力してください')
      end
    end

    context 'description column' do
      it 'success. blank is allowed' do
        t = Task.new(
          title: 'ThisIsTitle',
          description: '',
        )
        expect(t).to be_valid
      end

      it 'failed when it is too long' do
        t = Task.new(
          title: 'ThisIsTitle',
          description: SecureRandom.alphanumeric(501),
        )
        t.valid?
        expect(t.errors[:description]).to include('は500文字以内で入力してください')
      end
    end

    context 'due_date_at column' do
      it 'success.' do
        t = Task.new(
          title: 'ThisIsTitle',
          due_date_at: '2024/08/31',
        )
        expect(t).to be_valid
      end

      it 'failed when it is invalid date' do
        t = Task.new(
          title: 'ThisIsTitle',
          due_date_at: '2024/99/99',
        )
        t.valid?

        expect(t.errors[:due_date_at]).to include('は不正な値です')
      end

      it 'failed when it is invalid format' do
        t = Task.new(
          title: 'ThisIsTitle',
          due_date_at: 'invalid_format!?',
        )
        t.valid?

        expect(t.errors[:due_date_at]).to include('は不正な値です')
      end
    end

    context 'status column' do
      it 'success.' do
        t = Task.new(
          title: 'ThisIsTitle',
          status: 2,
        )
        expect(t).to be_valid
      end
      it 'failed when it is invalid status' do
        t = Task.new(
          title: 'ThisIsTitle',
          status: '999',
        )
        t.valid?

        expect(t.errors[:status]).to include('は不正な値です')
      end
    end
  end
end
