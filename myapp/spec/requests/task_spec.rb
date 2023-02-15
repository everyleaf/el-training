require 'rails_helper'

RSpec.describe 'Tasks', type: :request do
  describe 'GET /index' do
    let(:tasks) { create_list(:task, 10) }

    it 'renders a successful response' do
      get tasks_url
      expect(response).to have_http_status(:ok)
    end
  end

  describe 'GET /new' do
    it 'renders a successful response' do
      get new_task_url
      expect(response).to have_http_status(:ok)
    end
  end

  describe 'GET /edit' do
    let(:task) { create(:task) }

    it 'renders a successful response' do
      get edit_task_url(task)
      expect(response).to have_http_status(:ok)
    end
  end

  describe 'POST /create' do
    context 'with parameters' do
      let(:params) do
        { task: {
          title: 'task',
          priority: 'low',
          status: 'working',
          description: 'task desu',
          expires_at: Time.now + 1.week
        } }
      end
      it 'creates a new Task' do
        expect do
          post tasks_url, params:
        end.to change(Task, :count).by(1)
      end
      it 'redirects to the new Task' do
        post(tasks_url, params:)
        expect(response).to redirect_to(task_url(Task.last))
      end
    end

    describe 'PUT /update' do
      context 'with parameters' do
        let!(:task) { create(:task) }

        let(:new_attributes) do
          {
            title: 'updated',
            expires_at: Time.now + 1.week,
            priority: 'high',
            status: 'completed',
            description: 'updated task'
          }
        end

        it 'updates the requested task' do
          put task_url(task), params: { task: new_attributes }
          expect(task.reload).to have_attributes new_attributes.except(:expires_at)
        end

        it 'redirects to the task' do
          put task_url(task), params: { task: new_attributes }
          expect(response).to redirect_to(task_url(task.reload))
        end
      end
    end

    describe 'DELETE /destroy' do
      let!(:task) { create(:task) }

      it 'destroys the requested task' do
        expect do
          delete task_url(task)
        end.to change(Task, :count).by(-1)
      end

      it 'redirects to the tasks list' do
        delete task_url(task)

        expect(response).to redirect_to(tasks_url)
      end
    end
  end
end
