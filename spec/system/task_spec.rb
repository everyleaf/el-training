require 'rails_helper'

RSpec.describe 'Tasks', type: :system do
  it 'タスクの作成' do
    # タスク一覧ページを作成
    visit tasks_url

    # 作成リンクをクリック
    click_on 'タスクを作成'

    # 郵便番号を入力
    today = Time.zone.today
    fill_in 'Name',           with: 'sample task'
    fill_in 'Start date',     with: today
    fill_in 'Necessary days', with: 3
    choose  '未着手'
    choose  '低'

    # 更新実行
    click_button 'Create'

    # 正しくタスクが作成されていることを確認
    expect(page).to have_content 'sample task'
    expect(page).to have_content "#{today.mon}/#{today.mday}"
    expect(page).to have_content '3'
    expect(page).to have_content '未着手'
    expect(page).to have_content '低'
  end
end
