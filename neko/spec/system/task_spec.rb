require 'rails_helper'

describe 'task', type: :system do
  let!(:tasks) { FactoryBot.create_list(:task, 5) }

  describe '#index' do
    before { visit tasks_path }
    context 'accress root' do
      it 'should be success to access the task list' do
        expect(page).to have_content 'タスク一覧'
        expect(page).to have_content '名前'
        expect(page).to have_content '説明'
      end

      it 'tasks should be arrange in descending date order' do
        expect(page.all('.task-name').map(&:text)).to eq tasks.map { |h| h[:name] }.reverse
      end
    end

    context "click '名前'" do
      it 'is toggle sorting by task name' do
        names = tasks.map { |h| h[:name] }.sort { |a, b| b <=> a }
        click_on '名前'
        expect(page.all('.task-name').map(&:text)).to eq names
        click_on '名前'
        expect(page.all('.task-name').map(&:text)).to eq names.reverse
      end
    end

    context "click '説明'" do
      it 'is toggle sorting by task description' do
        descriptions = tasks.map { |h| h[:description] }.sort { |a, b| b <=> a }
        click_on '説明'
        expect(page.all('.task-description').map(&:text)).to eq descriptions
        click_on '説明'
        expect(page.all('.task-description').map(&:text)).to eq descriptions.reverse
      end
    end

    context "click '作成日'" do
      it 'is toggle sorting by creation date' do
        created_at = tasks.map { |h| I18n.l(h[:created_at]) }.sort { |a, b| b <=> a }
        click_on '作成日'
        expect(page.all('.task-created_at').map(&:text)).to eq created_at
        click_on '作成日'
        expect(page.all('.task-created_at').map(&:text)).to eq created_at.reverse
      end
    end

    context "click '期限'" do
      it 'is toggle sorting by due time' do
        due_desc = []
        i = tasks.length
        tasks.each do |t|
          if t.have_a_due
            due_desc.push I18n.l(t.due_at)
            i -= 1
          end
        end

        # sorting by deadline
        due_desc = due_desc.sort { |a, b| b <=> a }
        due_asc = due_desc.reverse

        # reordering of unspecified deadlines
        i.times do
          due_desc.push ''
          due_asc.push ''
        end

        click_on '期限'
        expect(page.all('.task-due_at').map(&:text)).to eq due_desc
        click_on '期限'
        expect(page.all('.task-due_at').map(&:text)).to eq due_asc
      end
    end
  end

  describe '#new (GET /tasks/new)' do
    before { visit new_task_path }

    context 'name is more than one letter' do
      it 'should be success' do
        fill_in '名前', with: 'hoge'
        fill_in '説明', with: 'fuga'

        click_on '登録する'
        expect(page).to have_content 'タスクを作成しました'
      end
    end

    context 'name is blank' do
      it 'should be failure' do
        fill_in '名前', with: ''
        fill_in '説明', with: 'piyo'

        click_on '登録する'
        expect(page).to have_content 'タスクの作成に失敗しました'
      end
    end
  end

  describe '#edit (GET /tasks/:id/edit)' do
    before { visit edit_task_path(tasks[0].id) }
    context 'name is more than one letter' do
      it 'should be success' do
        fill_in '名前', with: 'hogehoge'
        fill_in '説明', with: 'fugaguga'

        click_on '更新する'
        expect(page).to have_content 'タスクを更新しました'
      end
    end

    context 'name is blank' do
      it 'should be failure' do
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
        visit task_path(tasks[0].id)

        expect(page).to have_content 'タスク詳細'
        expect(page).to have_content tasks[0].name
        expect(page).to have_content tasks[0].description
      end
    end
  end

  describe '#delete (DELETE /tasks/:id)', js: true do
    context 'push delete button from detail page' do
      it 'should be success to delete the task' do
        visit task_path(tasks[0].id)

        # confirm dialog
        page.accept_confirm do
          click_on '削除'
        end
        expect(page).to have_content 'タスクを削除しました'
      end
    end
  end
end
