require 'rails_helper'

RSpec.describe 'Todos', type: :request do
  let!(:todo) { create(:todo)}

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

    it "should have the todo" do
      expect(page).to have_content('Sample title')
      expect(page).to have_content('Sample content')
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
        end

        context 'title is not nil' do
          before do
            fill_in 'title', with: 'hoge'
            fill_in 'content', with: 'fuga'
            click_on I18n.t('dictionary.create')
          end

          it_behaves_like 'have a header'

          it 'should be index page after creating' do
            expect(current_path).to eq '/'
          end

          it 'should show a flash message' do
            expect(page).to have_content('New todo has been created.')
          end

          it 'should show the created todo' do
            expect(page).to have_link('hoge')
            expect(page).to have_content('fuga')
          end

          describe 'detail page' do
            before { click_on 'Sample title' }

            it_behaves_like 'have a header'

            it 'should have the title and content of the todo' do
              expect(page).to have_content('Sample title')
              expect(page).to have_content('Sample content')
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

              it 'should have the title and content of the todo' do
                expect(page).to have_field('title', with: 'Sample title')
                expect(page).to have_field('content', with: 'Sample content')
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

                  it 'should keep the content' do
                    expect(page).to have_field('content', with: 'Sample content')
                  end
                end

                context 'title is not nil' do
                  before do
                    fill_in 'title', with: 'Edited title'
                    fill_in 'content', with: 'Edited content'
                    click_on I18n.t('dictionary.update')
                  end

                  it_behaves_like 'have a header'

                  it 'should be detail page after updating todo' do
                    expect(current_path).to eq "/todos/#{todo.id}/detail"
                  end

                  it 'should show the updated content' do
                    expect(page).to have_content('Edited title')
                    expect(page).to have_content('Edited content')
                  end

                  it 'should show a flash message' do
                    expect(page).to have_content('Todo has been updated.')
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
                expect(page).to_not have_link('Sample Title')
                expect(page).to_not have_content('Sample Content')
              end

              it 'should show a flash message' do
                expect(page).to have_content('Todo has been deleted.')
              end
            end
          end
        end
      end
    end
  end
end
