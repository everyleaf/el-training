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

    context 'カテゴリ名を空のまま作成ボタンを押したとき' do
      it 'カテゴリの作成に失敗する' do
        # フォームにカテゴリ名を入力せずに
        fill_in 'カテゴリ名', with: ''
        # 作成ボタンを押す
        click_on '作成'

        # 作成成功のメッセージが表示され
        expect(page).to have_content 'カテゴリ名を入力してください'
      end
    end

    context '存在するカテゴリ名を入力したとき' do
      let!(:category) { create(:category, name: 'test_category') }
      it '作成に失敗する' do
        # すでに存在するカテゴリ名を入力して
        fill_in 'カテゴリ名', with: category.name
        # 作成ボタンを押す
        click_on '作成'

        # カテゴリ名が重複している、とメッセージが出る
        expect(page).to have_content('カテゴリ名はすでに存在します')
      end
    end
  end
end
