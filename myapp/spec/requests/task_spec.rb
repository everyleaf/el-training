require 'rails_helper'

RSpec.describe 'Tasks', type: :request do
  let!(:user) { create(:user) }

  describe 'GET /index' do
    let(:tasks) { create_list(:task, 10) }

    it 'renders a successful response' do
      get tasks_url
      expect(response).to have_http_status(:ok)
    end

    context "When URL has argument 'sort'" do
      let!(:tasks) { 11.times.map { create(:task, user_id: user.id) } }

      context 'created_at_asc' do
        let(:params) do
          { sort: 'created_at_asc' }
        end

        it 'renders a successful response' do
          get(tasks_url, params:)

          expect(response).to have_http_status(:ok)
          Task.all.slice(0..9).each { |task| expect(response.body).to include task.title.to_s }
          expect(response.body).to include Task.all.last.title.to_s
        end
      end
      context 'created_at_desc' do
        let(:params) do
          { sort: 'created_at_desc' }
        end

        it 'renders a successful response' do
          get(tasks_url, params:)

          expect(response).to have_http_status(:ok)
          Task.all.reverse.slice(0..9).each { |task| expect(response.body).to include task.title.to_s }
          expect(response.body).to include Task.all.reverse.last.title.to_s
        end
      end
      context "When URL has argument 'sort'" do
        let!(:tasks) { 11.times.map { create(:task, user_id: user.id) } }

        context 'expires_at_asc' do
          let(:params) do
            { sort: 'expires_at_asc' }
          end

          it 'renders a successful response' do
            get(tasks_url, params:)

            expect(response).to have_http_status(:ok)
            Task.all.slice(0..9).each { |task| expect(response.body).to include task.title.to_s }
            expect(response.body).to include Task.all.last.title.to_s
          end
        end
        context 'expires_at_desc' do
          let(:params) do
            { sort: 'expires_at_desc' }
          end

          it 'renders a successful response' do
            get(tasks_url, params:)

            expect(response).to have_http_status(:ok)
            Task.all.reverse.slice(0..9).each { |task| expect(response.body).to include task.title.to_s }
            expect(response.body).to include Task.all.reverse.last.title.to_s
          end
        end
      end
    end
    context "When URL has argument 'status'" do
      let!(:first_task) do
        create(:task, title: 'test1', description: 'aaa', priority: 'low', status: 'waiting', user_id: user.id,
                      expires_at: '2023/01/03 00:00')
      end
      let!(:second_task) do
        create(:task, title: 'test2', description: 'bbb', priority: 'middle', status: 'waiting', user_id: user.id,
                      expires_at: '2023/01/02 00:00')
      end
      let!(:third_task) do
        create(:task, title: 'test3', description: 'ccc', priority: 'high', status: 'doing', user_id: user.id,
                      expires_at: '2023/01/01 00:00')
      end
      let!(:fourth_task) do
        create(:task, title: 'test4', description: 'ddd', priority: 'middle', status: 'completed', user_id: user.id,
                      expires_at: '2023/01/04 00:00')
      end
      let!(:fifth_task) do
        create(:task, title: 'test5', description: 'eee', priority: 'low', status: 'completed', user_id: user.id,
                      expires_at: '2023/01/05 00:00')
      end
      let!(:sixth_task) do
        create(:task, title: 'test6', description: 'fff', priority: 'high', status: 'completed', user_id: user.id,
                      expires_at: '2023/01/06 00:00')
      end

      context 'status: waiting' do
        let(:params) do
          { status: 'waiting' }
        end
        it 'renders a successful response' do
          get(tasks_url, params:)

          expect(response).to have_http_status(:ok)
          expect(response.body).to include 'test1'
          expect(response.body).to include 'test2'
          expect(response.body).not_to include 'test3'
          expect(response.body).not_to include 'test4'
          expect(response.body).not_to include 'test5'
          expect(response.body).not_to include 'test6'
        end
      end
      context 'status: doing' do
        let(:params) do
          { status: 'doing' }
        end
        it 'renders a successful response' do
          get(tasks_url, params:)

          expect(response).to have_http_status(:ok)
          expect(response.body).not_to include 'test1'
          expect(response.body).not_to include 'test2'
          expect(response.body).to include 'test3'
          expect(response.body).not_to include 'test4'
          expect(response.body).not_to include 'test5'
          expect(response.body).not_to include 'test6'
        end
      end
      context 'status: completed' do
        let(:params) do
          { status: 'completed' }
        end
        it 'renders a successful response' do
          get(tasks_url, params:)

          expect(response).to have_http_status(:ok)
          expect(response.body).not_to include 'test1'
          expect(response.body).not_to include 'test2'
          expect(response.body).not_to include 'test3'
          expect(response.body).to include 'test4'
          expect(response.body).to include 'test5'
          expect(response.body).to include 'test6'
        end
      end
    end
    context "When URL has argument 'keyword'" do
      let!(:first_task) do
        create(:task, title: 'あいうえお', description: 'a', priority: 'low', status: 'waiting', user_id: user.id,
                      expires_at: '2023/01/03 00:00')
      end
      let!(:second_task) do
        create(:task, title: 'かきくけこ', description: 'b', priority: 'middle', status: 'waiting', user_id: user.id,
                      expires_at: '2023/01/02 00:00')
      end
      let!(:third_task) do
        create(:task, title: 'さしすせそ', description: 'c', priority: 'high', status: 'doing', user_id: user.id,
                      expires_at: '2023/01/01 00:00')
      end
      context "keyword: 'a'" do
        let(:params) do
          { keyword: 'a' }
        end
        it 'renders a successful response' do
          get(tasks_url, params:)

          expect(response).to have_http_status(:ok)
          expect(response.body).to include 'あいうえお'
          expect(response.body).not_to include 'かきくけこ'
          expect(response.body).not_to include 'さしすせそ'
        end
      end
      context "When there are over 10 tasks and using pagenation" do

      end
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
