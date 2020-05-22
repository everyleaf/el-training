require 'rails_helper'

describe 'task', type: :system do
  let!(:not_proceed) { create(:not_proceed) }
  let!(:in_progress) { create(:in_progress) }
  let!(:done) { create(:done) }

  let!(:task1) do
    create(:task, name: 'task1', description: 'a', status: in_progress,
                  have_a_due: true, due_at: Time.zone.local(2020, 9, 30, 17, 30))
  end
  let!(:task2) do
    create(:task, name: 'task2', description: 'c', status: done,
                  have_a_due: false, due_at: Time.zone.local(2020, 7, 10, 10, 15))
  end
  let!(:task3) do
    create(:task, name: 'task3', description: 'b', status: not_proceed,
                  have_a_due: true, due_at: Time.zone.local(2020, 8, 15, 16, 59))
  end

  describe '#index' do
    before { visit tasks_path }
    context 'accress root' do
      it 'should be success to access the task list' do
        expect(page).to have_content 'タスク一覧'
        expect(page).to have_content '名前'
        expect(page).to have_content '説明'
        expect(page).to have_content 'ステータス'
        expect(page).to have_content '期限'
        expect(page).to have_content '作成日'
      end

      it 'should sorts the tasks in descending date order' do
        order = %w[task3 task2 task1]
        expect(page.all('.task-name').map(&:text)).to eq order
      end
    end

    context 'click item name' do
      it 'reorders the tasks based on items' do
        cases = [
          { button: '名前', order: %w[task3 task2 task1] },
          { button: '説明', order: %w[task2 task3 task1] },
          { button: '作成日', order: %w[task3 task2 task1] },
          { button: '期限', order: %w[task1 task3 task2], order2: %w[task3 task1 task2] },
          { button: 'ステータス', order: %w[task2 task1 task3] }
        ]

        cases.each do |c|
          click_on c[:button]
          expect(page.all('.task-name').map(&:text)).to eq c[:order]

          click_on c[:button]
          c[:order2] = c[:order].reverse if c[:order2].nil?
          expect(page.all('.task-name').map(&:text)).to eq c[:order2]
        end
      end
    end

    context 'click item name' do
      it 'reorders the tasks based on items' do
        cases = %w[未着手 着手中 完了]
        cases.each do |c|
          select(c, from: 'status_id')
          click_on '検索'

          page.all('.task-status').map(&:text).each do |s|
            expect(s).to eq c
          end
        end
      end
    end
  end

  describe '#new (GET /tasks/new)' do
    before { visit new_task_path }

    context 'name is more than one letter' do
      it 'should be success to create' do
        fill_in '名前', with: 'hoge'
        fill_in '説明', with: 'fuga'

        click_on '登録する'
        expect(page).to have_content 'タスクを作成しました'
      end
    end

    context 'name is blank' do
      it 'should be failure to create' do
        fill_in '名前', with: ''
        fill_in '説明', with: 'piyo'

        click_on '登録する'
        expect(page).to have_content 'タスクの作成に失敗しました'
      end
    end
  end

  describe '#edit (GET /tasks/:id/edit)' do
    before { visit edit_task_path(task1.id) }
    context 'name is more than one letter' do
      it 'should be success to update' do
        fill_in '名前', with: 'hogehoge'
        fill_in '説明', with: 'fugaguga'

        click_on '更新する'
        expect(page).to have_content 'タスクを更新しました'
      end
    end

    context 'name is blank' do
      it 'should be failure to update' do
        fill_in '名前', with: ''
        fill_in '説明', with: 'piyopiyo'

        click_on '更新する'
        expect(page).to have_content 'タスクの更新に失敗しました'
      end
    end
  end

  describe '#show (GET /tasks/:id)' do
    context 'access the detail page' do
      it 'should be success' do
        visit task_path(task1.id)

        expect(page).to have_content 'タスク詳細'
        expect(page).to have_content 'task1'
        expect(page).to have_content 'a'
        expect(page).to have_content '着手中'
        expect(page).to have_content '2020/09/30 17:30'
      end
    end
  end

  describe '#delete (DELETE /tasks/:id)', js: true do
    context 'push delete button from detail page' do
      it 'should be success to delete the task' do
        visit task_path(task1.id)

        # confirm dialog
        page.accept_confirm do
          click_on '削除'
        end
        expect(page).to have_content 'タスクを削除しました'
      end
    end
  end
end
