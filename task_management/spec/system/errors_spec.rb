require 'rails_helper'

RSpec.describe 'error handling', type: :system do
  describe '#render404' do
    context '存在しないパスにアクセスし、RoutingErrorが発生した場合' do
      it 'エラーコード404用のベージに遷移すること' do
        visit '/nopage'
        expect(page).to have_content '404 Not Found'
        expect(page).to have_content 'お探しのページが見つかりません。'
      end
    end

    context '存在しないタスクにアクセスし、RecordNotFoundが発生した場合' do
      it 'エラーコード404用のベージに遷移すること' do
        visit task_path(9999999)
        expect(page).to have_content '404 Not Found'
        expect(page).to have_content 'お探しのページが見つかりません。'
      end
    end
  end

  describe '#render500' do
    it 'エラーコード500用のベージに遷移すること' do
      allow_any_instance_of(TasksController).to receive(:index).and_throw(Exception)
      visit tasks_path
      expect(page).to have_content '500 Internal Server Error'
      expect(page).to have_content 'サーバーの問題でお探しのページを表示できません。再度時間をおいてアクセスしてください。'
    end
  end
end
