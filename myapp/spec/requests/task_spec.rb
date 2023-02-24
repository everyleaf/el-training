require 'rails_helper'

RSpec.describe 'Tasks', type: :request do
  let!(:user) { create(:user) }

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
    context 'with valid parameters' do
      let(:params) do
        { task: {
          title: 'task',
          priority: 'low',
          status: 'doing',
          description: 'task desu',
          expires_at: 1.week.since,
          user_id: 1
        } }
      end
      it 'creates a new Task' do
        expect { post tasks_url, params: }.to change(Task, :count).by(1)
      end
      it 'redirects to the new Task' do
        post(tasks_url, params:)
        expect(response).to redirect_to(task_url(Task.last))
        expect(response).to have_http_status(:found)
        expect(flash[:notice])
      end

      context 'with invalid parameters' do
        let(:invalid_params) do
          { task: {
            title: 'nagai' * 255,
            priority: 'low',
            status: 'doing',
            description: 'task desu!',
            expires_at: 1.week.since,
            user_id: 1
          } }
        end

        it 'does not create a new Task' do
          expect { post tasks_url, params: invalid_params }.to change(Task, :count).by(0)
        end

        it 'does not create a new Task' do
          post tasks_url, params: invalid_params
          expect(response).to have_http_status(:unprocessable_entity)
          expect(response.body).to include 'タスク名は255文字以内で入力してください'
        end
      end
    end

    describe 'PUT /update' do
      context 'with valid parameters' do
        let!(:task) { create(:task) }

        let(:test_params) do
          {
            title: 'updated',
            expires_at: 1.week.since,
            priority: 'high',
            status: 'completed',
            description: 'updated task'
          }
        end

        let(:expect_params) do
          {
            title: 'updated',
            expires_at: 1.week.since,
            priority: 'high',
            status: 'completed',
            description: 'updated task'
          }
        end

        it 'updates the requested task' do
          put task_url(task), params: { task: test_params }
          expect(task.reload).to have_attributes expect_params.except(:expires_at)
        end

        it 'redirects to the task' do
          put task_url(task), params: { task: test_params }
          expect(response).to redirect_to(task_url(task.reload))
          expect(flash[:notice])
        end
      end

      context 'with invalid parameters' do
        let!(:task) { create(:task) }
        let(:invalid_params) do
          { task: {
            title: 'nagai' * 255,
            priority: 'low',
            status: 'doing',
            description: 'task desu!',
            expires_at: 1.week.since
          } }
        end

        it 'does not update the task' do
          put task_url(task), params: invalid_params

          expect(response).to have_http_status(:unprocessable_entity)
          expect(response.body).to include 'タスク名は255文字以内で入力してください'
        end
      end
    end

    describe 'DELETE /destroy' do
      context 'normal delete' do
        let!(:task) { create(:task, user_id: user.id) }

        it 'destroys the requested task' do
          expect { delete task_url(task) }.to change(Task, :count).by(-1)
          expect(flash[:notice])
        end

        it 'redirects to the tasks list' do
          delete task_url(task)
          expect(response).to have_http_status(:found)
          expect(response).to redirect_to(tasks_url)
        end
      end
      context 'nonormal delete' do
        it 'destroys the requested task' do
          expect { delete task_url }.to raise_error(ActionController::UrlGenerationError)
        end
      end
    end
  end
end
