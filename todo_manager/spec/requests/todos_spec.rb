require 'rails_helper'

RSpec.describe 'Todos', type: :request do
  let!(:todo) { create(:todo) }

  shared_examples_for 'have a header' do
    describe 'header' do
      it 'should have a header and the index link' do
        expect(page).to have_link(I18n.t('title'), href: '/')
      end
    end
  end

  describe 'Home (index) page' do
    before { visit '/' }

    it_behaves_like 'have a header'

    it "should have the word 'Todo List'" do
      expect(page).to have_content(I18n.t('todos.index.title'))
    end

    it 'should have the todo' do
      expect(page).to have_content(todo.title)
      expect(page).to have_content(todo.content)
      expect(page).to have_content(I18n.l(todo.deadline, format: :long))
    end

    it 'should show the todo ordered by created_at as desc' do
      create(:todo, title: 'test1', content: 'one', created_at: 1.hours.since, updated_at: 1.hours.since)
      create(:todo, title: 'test2', content: 'two', created_at: 2.hours.since, updated_at: 2.hours.since)
      create(:todo, title: 'test3', content: 'three', created_at: 3.hours.since, updated_at: 3.hours.since)
      visit '/'
      trs = page.all('tr')
      expect(trs[1]).to have_content('three')
      expect(trs[2]).to have_content('two')
      expect(trs[3]).to have_content('one')
    end

    describe 'sort todos by deadline' do
      before do
        create(:todo, title: 'hoge', status_id: 1, deadline: 2.days.since)
        create(:todo, title: 'hoge', status_id: 1, deadline: 3.days.since)
        click_on I18n.t('dictionary.deadline')
      end
      context 'in asc' do
        it 'should be ordered' do
          trs = page.all('tr')
          expect(trs[1]).to have_content(1.day.since.strftime('%Y/%m/%d %H:%M'))
          expect(trs[2]).to have_content(2.days.since.strftime('%Y/%m/%d %H:%M'))
          expect(trs[3]).to have_content(3.days.since.strftime('%Y/%m/%d %H:%M'))
        end

        it 'should be refined by status_id' do
          click_on(I18n.t('status.id1'))
          trs = page.all('tr')
          expect(trs[1]).to have_content(2.days.since.strftime('%Y/%m/%d %H:%M'))
          expect(trs[2]).to have_content(3.days.since.strftime('%Y/%m/%d %H:%M'))
        end

        it 'should be refined by title' do
          fill_in 'search', with: 'hoge'
          click_on(I18n.t('dictionary.search'))
          trs = page.all('tr')
          expect(trs[1]).to have_content(2.days.since.strftime('%Y/%m/%d %H:%M'))
          expect(trs[2]).to have_content(3.days.since.strftime('%Y/%m/%d %H:%M'))
        end
      end

      context 'in desc' do
        before { click_on I18n.t('dictionary.deadline') }
        it 'should be ordered' do
          trs = page.all('tr')
          expect(trs[1]).to have_content(3.days.since.strftime('%Y/%m/%d %H:%M'))
          expect(trs[2]).to have_content(2.days.since.strftime('%Y/%m/%d %H:%M'))
          expect(trs[3]).to have_content(1.day.since.strftime('%Y/%m/%d %H:%M'))
        end

        it 'should be refined by status_id' do
          click_on(I18n.t('status.id1'))
          trs = page.all('tr')
          expect(trs.count).to eq 3
          expect(trs[1]).to have_content(3.days.since.strftime('%Y/%m/%d %H:%M'))
          expect(trs[2]).to have_content(2.days.since.strftime('%Y/%m/%d %H:%M'))
        end

        it 'should be refined by title' do
          fill_in 'search', with: 'hoge'
          click_on(I18n.t('dictionary.search'))
          trs = page.all('tr')
          expect(trs.count).to eq 3
          expect(trs[1]).to have_content(3.days.since.strftime('%Y/%m/%d %H:%M'))
          expect(trs[2]).to have_content(2.days.since.strftime('%Y/%m/%d %H:%M'))
        end
      end
    end

    describe 'refine search' do
      context 'with status_id' do
        before do
          create(:todo, status_id: 1)
          create(:todo, status_id: 2)
        end
        it 'can be refined by status_id: 0' do
          click_on I18n.t('status.id0')
          trs = page.all('tr')
          trs.each do |tr|
            expect(tr).not_to have_content(I18n.t('status.id1'))
            expect(tr).not_to have_content(I18n.t('status.id2'))
          end
          expect(trs.last).to have_content(I18n.t('status.id0'))
        end

        it 'can be refined by status_id: 1' do
          click_on I18n.t('status.id1')
          trs = page.all('tr')
          trs.each do |tr|
            expect(tr).not_to have_content(I18n.t('status.id0'))
            expect(tr).not_to have_content(I18n.t('status.id2'))
          end
          expect(trs.last).to have_content(I18n.t('status.id1'))
        end

        it 'can be refined by status_id: 2' do
          click_on I18n.t('status.id2')
          trs = page.all('tr')
          trs.each do |tr|
            expect(tr).not_to have_content(I18n.t('status.id0'))
            expect(tr).not_to have_content(I18n.t('status.id1'))
          end
          expect(trs.last).to have_content(I18n.t('status.id2'))
        end

        it 'shows all status when clicking all' do
          click_on I18n.t('dictionary.all')
          trs = page.all('tr')
          expect(trs.count).to eq 4
        end
      end

      context 'with title' do
        it 'can be refined by title' do
          create(:todo, title: 'hoge')
          fill_in 'search', with: 'hoge'
          click_on I18n.t('dictionary.search')
          trs = page.all('tr')
          trs.each do |tr|
            expect(tr).not_to have_content(todo.title)
          end
          expect(trs.last).to have_content('hoge')
        end
      end

      context 'with both status_id and title' do
        before do
          create(:todo, title: 'hoge', status_id: 0)
          create(:todo, title: 'fuga', status_id: 0)
          create(:todo, title: 'hoge', status_id: 1)
          create(:todo, title: 'fuga', status_id: 1)
          create(:todo, title: 'hoge', status_id: 2)
          create(:todo, title: 'fuga', status_id: 2)
          fill_in 'search', with: 'hoge'
          click_on I18n.t('dictionary.search')
        end
        it 'can be refined by status_id: 0 and title' do
          click_on I18n.t('status.id0')
          @trs = page.all('tr')
          expect(@trs.count).to eq 2
          expect(@trs.last).to have_content('hoge')
        end

        it 'can be refined by status_id: 1 and title' do
          click_on I18n.t('status.id1')
          @trs = page.all('tr')
          expect(@trs.count).to eq 2
          expect(@trs.last).to have_content('hoge')
        end

        it 'can be refined by status_id: 2 and title' do
          click_on I18n.t('status.id2')
          @trs = page.all('tr')
          expect(@trs.count).to eq 2
          expect(@trs.last).to have_content('hoge')
        end
      end
    end

    it 'should have the create link' do
      expect(page).to have_link(I18n.t('dictionary.create'), href: '/todos/new')
    end

    describe 'create page' do
      before { click_on I18n.t('dictionary.create') }

      it_behaves_like 'have a header'

      it "should have the word 'Create Todo'" do
        expect(page).to have_content(I18n.t('todos.new.title'))
      end

      describe 'create new todo' do
        context 'title is nil' do
          before do
            fill_in 'content', with: 'fuga'
            fill_in 'deadline', with: '2099-08-01T12:00'
            click_on I18n.t('dictionary.create')
          end

          it 'should back to the create page' do
            expect(current_path).to eq '/todos/create'
          end

          it 'should show an error message' do
            expect(page).to have_content("Title #{I18n.t('errors.messages.blank')}")
          end

          it 'should keep the content' do
            expect(page).to have_field('content', with: 'fuga')
          end

          it 'should keep the deadline' do
            expect(page).to have_field('deadline', with: '2099-08-01T12:00')
          end
        end

        context 'title is not nil' do
          before do
            fill_in 'title', with: 'hoge'
            fill_in 'content', with: 'fuga'
            fill_in 'deadline', with: '2099-08-01T12:00'
            click_on I18n.t('dictionary.create')
          end

          it_behaves_like 'have a header'

          it 'should be index page after creating' do
            expect(current_path).to eq '/'
          end

          it 'should show a flash message' do
            expect(page).to have_content(I18n.t('flash.todos.create'))
          end

          it 'should show the created todo' do
            expect(page).to have_link('hoge')
            expect(page).to have_content('fuga')
            expect(page).to have_content('2099/08/01 12:00')
          end

          describe 'detail page' do
            before { click_on todo.title }

            it_behaves_like 'have a header'

            it 'should have the title, content and deadline of the todo' do
              expect(page).to have_content(todo.title)
              expect(page).to have_content(todo.content)
              expect(page).to have_content(I18n.l(todo.deadline, format: :long))
            end

            it 'should have the edit and destroy link' do
              expect(page).to have_link(I18n.t('dictionary.edit'))
              expect(page).to have_link(I18n.t('dictionary.destroy'))
            end

            describe 'edit page' do
              before { click_on I18n.t('dictionary.edit') }

              it_behaves_like 'have a header'

              it "should have the content 'Edit Todo', title and content of the todo" do
                expect(page).to have_content(I18n.t('todos.edit.title'))
              end

              it 'should have the title, content and deadline of the todo' do
                expect(page).to have_field('title', with: todo.title)
                expect(page).to have_field('content', with: todo.content)
                expect(page).to have_field('deadline', with: todo.deadline.strftime('%Y-%m-%dT%H:%M'))
              end

              describe 'update the todo' do
                context 'title is nil' do
                  before do
                    fill_in 'title', with: ''
                    click_on I18n.t('dictionary.update')
                  end

                  it_behaves_like 'have a header'

                  it 'should back to the edit page' do
                    expect(page).to have_content(I18n.t('todos.edit.title'))
                  end

                  it 'should show an error message' do
                    expect(page).to have_content("Title #{I18n.t('errors.messages.blank')}")
                  end

                  it 'should keep the content and deadline' do
                    expect(page).to have_field('content', with: todo.content)
                  end

                  it 'should keep the deadline' do
                    expect(page).to have_field('deadline', with: todo.deadline.strftime('%Y-%m-%dT%H:%M'))
                  end
                end

                context 'title is not nil' do
                  before do
                    fill_in 'title', with: 'Edited title'
                    fill_in 'content', with: 'Edited content'
                    fill_in 'deadline', with: '2099-08-01T12:00'
                    click_on I18n.t('dictionary.update')
                  end

                  it_behaves_like 'have a header'

                  it 'should be detail page after updating todo' do
                    expect(current_path).to eq "/todos/#{todo.id}/detail"
                  end

                  it 'should show the updated content' do
                    expect(page).to have_content('Edited title')
                    expect(page).to have_content('Edited content')
                    expect(page).to have_content('2099/08/01 12:00')
                  end

                  it 'should show a flash message' do
                    expect(page).to have_content(I18n.t('flash.todos.update'))
                  end
                end
              end
            end

            describe 'destroy action' do
              before { click_on I18n.t('dictionary.destroy') }

              it 'should be index page after deleting todo' do
                expect(current_path).to eq '/'
              end

              it 'should delete todo' do
                expect(page).to_not have_link(todo.title)
                expect(page).to_not have_content(todo.content)
              end

              it 'should show a flash message' do
                expect(page).to have_content(I18n.t('flash.todos.destroy.success'))
              end
            end
          end
        end
      end
    end
  end
end
