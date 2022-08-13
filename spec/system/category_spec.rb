RSpec.describe 'Categories', type: :system do
  include LoginSupport

  let!(:user) { create(:user) }

  describe 'カテゴリの作成' do
    let!(:user) { create(:user) }
    before do
      login_as(user)
      click_on 'カテゴリ一覧'
    end

    context 'カテゴリ名を入力して作成ボタンを押したとき' do
      it 'カテゴリが作成される' do
        # フォームにカテゴリ名を入力して
        fill_in 'category_name', with: 'test_category'
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
        fill_in 'category_name', with: ''
        # 作成ボタンを押す
        click_on '作成'

        # 作成成功のメッセージが表示され
        expect(page).to have_content 'カテゴリの作成に失敗しました'
      end
    end

    context '存在するカテゴリ名を入力したとき' do
      let!(:category) { create(:category, name: 'test_category', user:) }
      it '作成に失敗する' do
        # すでに存在するカテゴリ名を入力して
        fill_in 'category_name', with: category.name
        # 作成ボタンを押す
        click_on '作成'

        # カテゴリ名が重複している、とメッセージが出る
        expect(page).to have_content('カテゴリの作成に失敗しました')
      end
    end
  end

  describe 'カテゴリの編集' do
    let!(:category) { create(:category, name: 'test_category', user:) }

    before do
      login_as(user)
      click_on 'カテゴリ一覧'
    end

    context 'カテゴリ名を正常に更新したとき' do
      it 'カテゴリ名の更新に成功する' do
        id = category.id
        find(".edit_category_#{id}").click

        # カテゴリ編集ページにいる
        expect(page).to have_content('カテゴリ名の変更')

        # 新しいカテゴリ名を入力
        fill_in 'category_name', with: 'updated_category'
        # 名前を変更ボタンを押す
        click_on '名前を変更'

        # カテゴリ名が正常に更新されている
        expect(page).to     have_content('カテゴリを更新しました')
        expect(page).to     have_content('updated_category')
        expect(page).not_to have_content('test_category')
      end
    end

    context '存在するカテゴリ名を使って更新しようとしたとき' do
      let!(:another_category) { create(:category, name: 'another', user:) }
      it '更新に失敗する' do
        # another_categoriesの作成をページに反映するために再アクセス
        visit categories_path

        id = another_category.id
        find(".edit_category_#{id}").click

        # すでに存在するカテゴリ名を使用
        fill_in 'category_name', with: category.name
        # 名前を変更ボタンを押す
        click_on '名前を変更'

        # カテゴリの更新に失敗する
        expect(page).to have_content('カテゴリの更新に失敗しました')
      end
    end
  end

  describe 'カテゴリの削除' do
    let!(:category) { create(:category, name: 'test_category',user:) }
    before do
      login_as(user)
      click_on 'カテゴリ一覧'
    end

    context '削除を押したとき' do
      it 'カテゴリが削除される' do
        name = category.name
        expect(page).to have_content(name)
        id = category.id

        # 削除ボタンをクリック
        find(".delete_category_#{id}").click

        # 確認のポップアップが表示される
        expect(page.accept_confirm).to eq '本当に削除しますか?'

        # 削除成功のメッセージが出る
        expect(page).to     have_content('カテゴリを削除しました')
        # 削除されたカテゴリ名はページに表示されていない
        expect(page).not_to have_content(name)
      end
    end
  end

  context 'タスクを子に持つカテゴリを削除したとき' do
    let!(:category) { create(:category, name: 'test_category',user:) }
    before do
      login_as(user)
      create(:task, category:)
    end

    it '削除に失敗する' do
      click_on 'カテゴリ一覧'

      id = category.id

      # 削除ボタンをクリック
      find(".delete_category_#{id}").click

      # 確認のポップアップが表示される
      expect(page.accept_confirm).to eq '本当に削除しますか?'

      # エラーメッセージが表示され
      expect(page).to have_content('カテゴリの削除に失敗しました')
      # カテゴリは削除されていない
      expect(page).to have_content('test_category')
    end
  end
end
