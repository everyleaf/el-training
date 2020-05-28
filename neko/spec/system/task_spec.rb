require 'rails_helper'

describe 'task', type: :system do
  let!(:task1) do
    create(:task, name: 'task1', description: 'a', status: 1,
                  have_a_due: true, due_at: Time.zone.local(2020, 9, 30, 17, 30))
  end
  let!(:task2) do
    create(:task, name: 'task2', description: 'c', status: 2,
                  have_a_due: false, due_at: Time.zone.local(2020, 7, 10, 10, 15))
  end
  let!(:task3) do
    create(:task, name: 'task3', description: 'b', status: 0,
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
        test_cases = [
          { button: '名前', order: %w[task3 task2 task1] },
          { button: '説明', order: %w[task2 task3 task1] },
          { button: '作成日', order: %w[task3 task2 task1] },
          { button: '期限', order: %w[task1 task3 task2], order2: %w[task3 task1 task2] },
          { button: 'ステータス', order: %w[task2 task1 task3] }
        ]

        test_cases.each do |test_case|
          click_on test_case[:button]
          expect(page.all('.task-name').map(&:text)).to eq test_case[:order]

          click_on test_case[:button]
          test_case[:order2] = test_case[:order].reverse if test_case[:order2].nil?
          expect(page.all('.task-name').map(&:text)).to eq test_case[:order2]
        end
      end
    end

    context 'click item name' do
      it 'reorders the tasks based on items' do
        test_cases = %w[未着手 着手中 完了]
        test_cases.each do |test_case|
          select(test_case, from: 'status')
          click_on '検索'

          page.all('.task-status').map(&:text).each do |s|
            expect(s).to eq test_case
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
