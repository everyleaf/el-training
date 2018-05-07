require 'rails_helper'

RSpec.describe Todo, type: :model do
  describe 'validation' do
    describe 'title' do
      context 'is nil' do
        it "can't be created" do
          expect { Todo.create!(title: '') }.to raise_error(ActiveRecord::RecordInvalid)
          # Tomonobu-san's style
          expect(Todo.new(title: '').valid?).to be false
        end
      end

      context 'is not nil' do
        it 'can be created' do
          expect { Todo.create!(title: 'hoge') }.not_to raise_error
        end
      end
    end
  end

  describe 'search' do
    let!(:todo) { create(:todo) }
    describe 'title' do
      it 'can be searched with title' do
        searched_todo = Todo.where(title: todo.title)
        expect(searched_todo.first.title).to eq todo.title
      end
    end

    describe 'status_id' do
      it 'can be searched with status_id' do
        searched_todo = Todo.where(status_id: todo.status_id)
        expect(searched_todo.first.status_id).to eq todo.status_id
      end
    end
  end
end