require 'rails_helper'

RSpec.describe Task, type: :model do
  # pending "add some examples to (or delete) #{__FILE__}"

  describe 'tasks' do
    context 'title' do
      it 'save and find correctly' do
        d = "this is example title"
        task = Task.new({title: d})
        task.save

        out = Task.find_by(title: d)
        expect(out.title).to eq d
      end
    end

    context 'description' do
      it 'save and find correctly' do
        d = "this is example title"
        task = Task.new({description: d})
        task.save

        out = Task.find_by(description: d)
        expect(out.title).to eq d
      end
    end

  end
end
