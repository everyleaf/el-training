# frozen_string_literal: true

require 'rails_helper'

RSpec.describe TasksController, type: :routing do
  describe 'routing' do
    let!(:task_id) { 
        create(:task, 
            owner_id: 1, 
            status:"waiting", 
            title: "task", 
            priority:0, 
            description:"taskです"
        ).id.to_s }

    it 'routes to #index' do
      expect(get: '/tasks').to route_to('tasks#index')
    end

    it 'routes to #new' do
      expect(get: '/tasks/new').to route_to('tasks#new')
    end

    it 'routes to #show' do
      expect(get: "/tasks/#{task_id}").to route_to('tasks#show', id: task_id)
    end

    it 'routes to #edit' do
      expect(get: "/tasks/#{task_id}/edit").to route_to('tasks#edit', id: task_id)
    end

    it 'routes to #create' do
      expect(post: '/tasks').to route_to('tasks#create')
    end

    it 'routes to #update via PUT' do
      expect(put: "/tasks/#{task_id}").to route_to('tasks#update', id: task_id)
    end

    it 'routes to #destroy' do
      expect(delete: "/tasks/#{task_id}").to route_to('tasks#destroy', id: task_id)
    end
  end
end