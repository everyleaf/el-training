require 'rails_helper'

RSpec.describe Todo, type: :model do
  describe 'validation' do
    describe 'user' do
      context 'is nil' do
        it 'should be false' do
          expect(Todo.new(title: 'hoge').valid?).to be false
        end
      end

      context 'is not nil' do
        describe 'title' do
          let!(:user) { create(:user) }
          context 'is nil' do
            it 'should be false' do
              expect(user.todos.new(title: '').valid?).to be false
            end
          end

          context 'is not nil' do
            it 'should be ok' do
              expect(user.todos.new(title: 'hoge').valid?).not_to be false
            end
          end
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
