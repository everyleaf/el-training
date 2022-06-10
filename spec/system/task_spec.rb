require 'rails_helper'

RSpec.describe 'Tasks', type: :system do

  # rubocop:disable RSpec/ExampleLength, RSpec/MultipleExpectations
  it 'タスクの作成' do 
    # タスク一覧ページを作成
    visit tasks_path

    # 作成リンクをクリック
    click_on 'タスクを作成'

    # フォームを埋める
    today = Time.zone.today
    fill_in 'Name',           with: 'sample task'
    fill_in 'Start date',     with: today
    fill_in 'Necessary days', with: 3
    choose  '未着手'
    choose  '低'

    # 作成実行
    click_button 'Create'

    # 正しくタスクが作成されていることを確認
    expect(page).to have_content 'sample task'
    expect(page).to have_content "#{today.mon}/#{today.mday}"
    expect(page).to have_content '3'
    expect(page).to have_content '未着手'
    expect(page).to have_content '低'
  end

  it 'タスクの更新' do
    # createのテストで作成したtaskを取得
    task = create(:task)

    # 詳細ページに移動
    visit task_path(task)

    # 正しい詳細ページに飛んだことを確認
    expect(page).to have_content 'test task'
    expect(page).to have_link '編集'
    expect(page).to have_button 'タスクを削除'

    # 作成実行
    click_link '編集'

    # 名前を空欄にして更新しようとすると失敗
    fill_in 'Name',with: ''
    click_button 'Save changes'
    expect(page).to have_content "Name can't be blank"

    # 新しい名前にして更新
    fill_in 'Name',with: 'updated task'
    click_button 'Save changes'

    # 更新成功
    expect(page).to have_content "Task Updated Successfully!"
    
    # 詳細ページにいることを確認
    expect(page).to have_link '編集'
    expect(page).to have_button 'タスクを削除'

    # タスク名が更新されていることを確認
    expect(page).to have_content 'updated task'
  end
end
