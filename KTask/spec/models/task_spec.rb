# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Task, type: :model do
  it 'タスクの有効性検査' do
    task = Task.new(
    title: 'spec test',
    content: 'this is spec test'
    )
    expect(task).to be_valid
  end
end
