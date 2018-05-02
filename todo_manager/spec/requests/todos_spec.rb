require 'rails_helper'

RSpec.describe 'Todos', type: :request do
  let!(:todo) { create(:todo) }
  subject { page }

  shared_examples_for 'have a header' do
    describe 'header' do
      it 'should have a header and the index link' do
        is_expected.to have_link(I18n.t('title'), href: '/')
      end
    end
  end

  describe 'Home (index) page' do
    before { visit '/' }

    it_behaves_like 'have a header'

    it "should have the word 'Todo List'" do
      is_expected.to have_content(I18n.t('views.todos.index.title'))
    end

    it 'should have the todo' do
      is_expected.to have_content(todo.title)
      is_expected.to have_content(todo.content)
      is_expected.to have_content(I18n.t("priority.id#{todo.priority_id}"))
      is_expected.to have_content(I18n.t("status.id#{todo.status_id}"))
      is_expected.to have_content(I18n.l(todo.deadline, format: :long))
    end

    it 'should show the todo ordered by created_at as desc' do
      create(:todo, title: 'test1', content: 'one', created_at: 1.hours.since, updated_at: 1.hours.since)
      create(:todo, title: 'test2', content: 'two', created_at: 2.hours.since, updated_at: 2.hours.since)
      create(:todo, title: 'test3', content: 'three', created_at: 3.hours.since, updated_at: 3.hours.since)
      visit '/'
      trs = page.all('tbody tr')
      expect(trs[0]).to have_content('three')
      expect(trs[1]).to have_content('two')
      expect(trs[2]).to have_content('one')
    end

    describe 'sort todos by deadline' do
      before do
        create(:todo, title: 'hoge', status_id: 1, deadline: 2.days.since)
        create(:todo, title: 'hoge', status_id: 1, deadline: 3.days.since)
        click_on I18n.t('dictionary.deadline')
      end
      context 'in asc' do
        it 'should be ordered' do
          trs = page.all('tbody tr')
          expect(trs[0]).to have_content(I18n.l(1.day.since, format: :long))
          expect(trs[1]).to have_content(I18n.l(2.days.since, format: :long))
          expect(trs[2]).to have_content(I18n.l(3.days.since, format: :long))
        end

        it 'should be refined by status_id' do
          click_on(I18n.t('status.id1'))
          trs = page.all('tbody tr')
          expect(trs[0]).to have_content(I18n.l(2.days.since, format: :long))
          expect(trs[1]).to have_content(I18n.l(3.days.since, format: :long))
        end

        it 'should be refined by title' do
          fill_in 'search', with: 'hoge'
          click_on(I18n.t('dictionary.search'))
          trs = page.all('tbody tr')
          expect(trs[0]).to have_content(I18n.l(2.days.since, format: :long))
          expect(trs[1]).to have_content(I18n.l(3.days.since, format: :long))
        end
      end

      context 'in desc' do
        before { click_on I18n.t('dictionary.deadline') }

        it 'should be ordered' do
          trs = page.all('tbody tr')
          expect(trs[0]).to have_content(I18n.l(3.days.since, format: :long))
          expect(trs[1]).to have_content(I18n.l(2.days.since, format: :long))
          expect(trs[2]).to have_content(I18n.l(1.day.since, format: :long))
        end

        it 'should be refined by status_id' do
          click_on(I18n.t('status.id1'))
          trs = page.all('tbody tr')
          expect(trs).to all(have_content(I18n.t('status.id1')))
          expect(trs[0]).to have_content(I18n.l(3.days.since, format: :long))
          expect(trs[1]).to have_content(I18n.l(2.days.since, format: :long))
        end

        it 'should be refined by title' do
          fill_in 'search', with: 'hoge'
          click_on(I18n.t('dictionary.search'))
          trs = page.all('tbody tr')
          expect(trs).to all(have_content('hoge'))
          expect(trs[0]).to have_content(I18n.l(3.days.since, format: :long))
          expect(trs[1]).to have_content(I18n.l(2.days.since, format: :long))
        end
      end
    end

    describe 'sort todos by priority' do
      before do
        create(:todo, title: 'hoge', priority_id: 0, status_id: 1)
        create(:todo, title: 'hoge', priority_id: 2, status_id: 1)
        click_on I18n.t('dictionary.priority')
      end
      context 'in asc' do
        it 'should be ordered' do
          trs = page.all('tbody tr')
          expect(trs[0]).to have_content(I18n.t('priority.id0'))
          expect(trs[1]).to have_content(I18n.t('priority.id1'))
          expect(trs[2]).to have_content(I18n.t('priority.id2'))
        end

        it 'should be refined by status_id' do
          click_on(I18n.t('status.id1'))
          trs = page.all('tbody tr')
          expect(trs).to all(have_content(I18n.t('status.id1')))
          expect(trs[0]).to have_content(I18n.t('priority.id0'))
          expect(trs[1]).to have_content(I18n.t('priority.id2'))
        end

        it 'should be refined by title' do
          fill_in 'search', with: 'hoge'
          click_on(I18n.t('dictionary.search'))
          trs = page.all('tbody tr')
          expect(trs).to all(have_content('hoge'))
          expect(trs[0]).to have_content(I18n.t('priority.id0'))
          expect(trs[1]).to have_content(I18n.t('priority.id2'))
        end
      end

      context 'in desc' do
        before { click_on I18n.t('dictionary.priority') }

        it 'should be ordered' do
          trs = page.all('tbody tr')
          expect(trs[0]).to have_content(I18n.t('priority.id2'))
          expect(trs[1]).to have_content(I18n.t('priority.id1'))
          expect(trs[2]).to have_content(I18n.t('priority.id0'))
        end

        it 'should be refined by status_id' do
          click_on(I18n.t('status.id1'))
          trs = page.all('tbody tr')
          expect(trs).to all(have_content(I18n.t('status.id1')))
          expect(trs[0]).to have_content(I18n.t('priority.id2'))
          expect(trs[1]).to have_content(I18n.t('priority.id0'))
        end

        it 'should be refined by title' do
          fill_in 'search', with: 'hoge'
          click_on(I18n.t('dictionary.search'))
          trs = page.all('tbody tr')
          expect(trs.count).to eq 2
          expect(trs).to all(have_content('hoge'))
          expect(trs[0]).to have_content(I18n.t('priority.id2'))
          expect(trs[1]).to have_content(I18n.t('priority.id0'))
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
          trs = page.all('tbody tr')
          expect(trs).to all(have_content(I18n.t('status.id0')))
        end

        it 'can be refined by status_id: 1' do
          click_on I18n.t('status.id1')
          trs = page.all('tbody tr')
          expect(trs).to all(have_content(I18n.t('status.id1')))
        end

        it 'can be refined by status_id: 2' do
          click_on I18n.t('status.id2')
          trs = page.all('tbody tr')
          expect(trs).to all(have_content(I18n.t('status.id2')))
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
          create(:todo, title: 'fuga')
          fill_in 'search', with: 'hoge'
          click_on I18n.t('dictionary.search')
          trs = page.all('tbody tr')
          expect(trs).to all(have_content('hoge'))
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

        describe 'refined by status_id and title' do
          context 'status_id: 0' do
            before { click_on I18n.t('status.id0') }
            let(:trs) { page.all('tbody tr') }
            it do
              expect(trs).to all(have_content('hoge'))
              expect(trs).to all(have_content(I18n.t('status.id0')))
            end
          end

          context 'status_id: 1' do
            before { click_on I18n.t('status.id1') }
            let(:trs) { page.all('tbody tr') }
            it do
              expect(trs).to all(have_content('hoge'))
              expect(trs).to all(have_content(I18n.t('status.id1')))
            end
          end

          context 'status_id: 2' do
            before { click_on I18n.t('status.id2') }
            let(:trs) { page.all('tbody tr') }
            it do
              expect(trs).to all(have_content('hoge'))
              expect(trs).to all(have_content(I18n.t('status.id2')))
            end
          end
        end
      end
    end

    it 'should have the create link' do
      is_expected.to have_link(I18n.t('dictionary.create'), href: '/todos/new')
    end

    describe 'create page' do
      before { click_on I18n.t('dictionary.create') }

      it_behaves_like 'have a header'

      it "should have the word 'Create Todo'" do
        is_expected.to have_content(I18n.t('views.todos.new.title'))
      end

      it 'should have the select box for the priority' do
        is_expected.to have_select('todo[priority_id]', options: I18n.t('priority').values)
      end

      describe 'create new todo' do
        context 'title is nil' do
          before do
            fill_in 'content', with: 'fuga'
            select I18n.t('priority.id0'), from: 'todo[priority_id]'
            fill_in 'deadline', with: '2099-08-01T12:00'
            click_on I18n.t('dictionary.create')
          end

          it 'should back to the create page' do
            expect(current_path).to eq '/todos/create'
          end

          it 'should show an error message' do
            is_expected.to have_content("Title #{I18n.t('errors.messages.blank')}")
          end

          it 'should keep the value' do
            is_expected.to have_field('content', with: 'fuga')
            is_expected.to have_select('todo[priority_id]', selected: I18n.t('priority.id0'))
            is_expected.to have_field('deadline', with: '2099-08-01T12:00')
          end
        end

        context 'title is not nil' do
          before do
            fill_in 'title', with: 'hoge'
            fill_in 'content', with: 'fuga'
            select I18n.t('priority.id0'), from: 'todo[priority_id]'
            fill_in 'deadline', with: Time.zone.parse('2099-08-01 12:00')
            click_on I18n.t('dictionary.create')
          end

          it_behaves_like 'have a header'

          it 'should be index page after creating' do
            expect(current_path).to eq '/'
          end

          it 'should show a flash message' do
            is_expected.to have_content(I18n.t('flash.todos.create'))
          end

          it 'should show the created todo' do
            is_expected.to have_link('hoge')
            is_expected.to have_content('fuga')
            is_expected.to have_content(I18n.t('priority.id0'))
            is_expected.to have_content(I18n.l(Time.zone.parse('2099-08-01 12:00'), format: :long))
          end

          describe 'detail page' do
            before { click_on todo.title }

            it_behaves_like 'have a header'

            it 'should have the value' do
              is_expected.to have_content(todo.title)
              is_expected.to have_content(todo.content)
              is_expected.to have_content(I18n.t('priority.id1'))
              is_expected.to have_content(I18n.t('status.id0'))
              is_expected.to have_content(I18n.l(todo.deadline, format: :long))
            end

            it 'should have the link' do
              is_expected.to have_link(I18n.t('dictionary.edit'))
              is_expected.to have_link(I18n.t('dictionary.destroy'))
            end

            describe 'edit page' do
              before { click_on I18n.t('dictionary.edit') }

              it_behaves_like 'have a header'

              it "should have the content 'Edit Todo', title and content of the todo" do
                is_expected.to have_content(I18n.t('views.todos.edit.title'))
              end

              it 'should have the value' do
                is_expected.to have_field('title', with: todo.title)
                is_expected.to have_field('content', with: todo.content)
                is_expected.to have_select('todo[priority_id]', selected: I18n.t("priority.id#{todo.priority_id}"))
                is_expected.to have_select('todo[status_id]', selected: I18n.t("status.id#{todo.status_id}"))
                is_expected.to have_field('deadline', with: todo.deadline.strftime('%Y-%m-%dT%H:%M'))
              end

              describe 'update the todo' do
                context 'title is nil' do
                  before do
                    fill_in 'title', with: ''
                    fill_in 'content', with: 'Edited content'
                    select I18n.t('priority.id0'), from: 'todo[priority_id]'
                    select I18n.t('status.id2'), from: 'todo[status_id]'
                    fill_in 'deadline', with: '2099-08-01T12:00'
                    click_on I18n.t('dictionary.update')
                  end

                  it_behaves_like 'have a header'

                  it 'should back to the edit page' do
                    is_expected.to have_content(I18n.t('views.todos.edit.title'))
                  end

                  it 'should show an error message' do
                    is_expected.to have_content("Title #{I18n.t('errors.messages.blank')}")
                  end

                  it 'should keep the edited value' do
                    is_expected.to have_field('content', with: 'Edited content')
                    is_expected.to have_select('todo[priority_id]', selected: I18n.t('priority.id0'))
                    is_expected.to have_select('todo[status_id]', selected: I18n.t('status.id2'))
                    is_expected.to have_field('deadline', with: '2099-08-01T12:00')
                  end
                end

                context 'title is not nil' do
                  before do
                    fill_in 'title', with: 'Edited title'
                    fill_in 'content', with: 'Edited content'
                    select I18n.t('priority.id0'), from: 'todo[priority_id]'
                    select I18n.t('status.id2'), from: 'todo[status_id]'
                    fill_in 'deadline', with: Time.zone.parse('2099-08-01 12:00')
                    click_on I18n.t('dictionary.update')
                  end

                  it_behaves_like 'have a header'

                  it 'should be detail page after updating todo' do
                    expect(current_path).to eq "/todos/#{todo.id}/detail"
                  end

                  it 'should show the updated content' do
                    is_expected.to have_content('Edited title')
                    is_expected.to have_content('Edited content')
                    is_expected.to have_content(I18n.t('priority.id0'))
                    is_expected.to have_content(I18n.t('status.id2'))
                    is_expected.to have_content(I18n.l(Time.zone.parse('2099/08/01 12:00'), format: :long))
                  end

                  it 'should show a flash message' do
                    is_expected.to have_content(I18n.t('flash.todos.update'))
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
                is_expected.to_not have_link(todo.title)
                is_expected.to_not have_content(todo.content)
              end

              it 'should show a flash message' do
                is_expected.to have_content(I18n.t('flash.todos.destroy.success'))
              end
            end
          end
        end
      end
    end
  end
end
