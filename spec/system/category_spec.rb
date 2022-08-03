RSpec.describe 'Categories', type: :system do
  describe 'カテゴリの作成' do
    before do
      visit categories_path
    end

    context 'カテゴリ名を入力して作成ボタンを押したとき' do
      it 'カテゴリが作成される' do
        # フォームにカテゴリ名を入力して
        fill_in 'カテゴリ名', with: 'test_category'
        # 作成ボタンを押す
        click_on '作成'

        # 作成成功のメッセージが表示され
        expect(page).to have_content 'カテゴリを作成しました'
        # カテゴリ名が表示されている
        expect(page).to have_content 'test_category'
      end
    end
  end
end