# frozen_string_literal: true

require 'rails_helper'
require 'pp'

RSpec.describe 'AdminUsers', type: :system do
  subject { page }

  before 'ログイン' do
    visit login_path
    fill_in 'email', with: login_user.email
    fill_in 'password', with: login_user.password
    click_button 'ログイン'
  end

  describe 'アクセス権' do
    let!(:login_user) { FactoryBot.create(:user) }

    context 'ログイン状態の時' do
      it '#indexにアクセスできること' do
        visit admin_users_path
        is_expected.to have_current_path admin_users_path
      end
    end

    context '未ログイン状態の時' do
      before do
        click_link nil, href: logout_path
      end
      it '#indexにアクセスできないこと' do
        visit admin_users_path
        is_expected.to have_current_path login_path
      end
    end
  end

  describe '#index (/admin/users)' do
    shared_examples '期待した順番で表示されること' do
      it do
        users_list = all('tbody tr')
        expected_list.each_with_index do |user, i|
          expect(users_list[i].all('td')[1].text).to eq user.email
        end
      end
    end

    describe '表示項目' do
      let!(:login_user) { FactoryBot.create(:user, name: '夏目', email: 'natsume@example.com') }
      it '期待した項目が表示されること' do
        visit admin_users_path
        is_expected.to have_content login_user.name
        is_expected.to have_content login_user.email
        is_expected.to have_content login_user.created_at.strftime('%Y/%m/%d %H:%M:%S')
        is_expected.to have_content login_user.updated_at.strftime('%Y/%m/%d %H:%M:%S')
      end
    end

    describe 'ソート機能' do
      describe 'ユーザ名' do
        let!(:login_user) { FactoryBot.create(:user, name: '4夏目', email: 'natsume@example.com') }
        let!(:user1) { FactoryBot.create(:user, name: '1田沼', email: 'tanuma@example.com') }
        let!(:user2) { FactoryBot.create(:user, name: '2多軌', email: 'taki@example.com') }
        let!(:user3) { FactoryBot.create(:user, name: '3ニャンコ先生', email: 'nyanko@example.com') }
        context '昇順' do
          before do
            visit admin_users_path
            click_link nil, id: 'name_asc'
          end
          let(:expected_list) { [user1, user2, user3, login_user] }
          it_behaves_like '期待した順番で表示されること'
        end
        context '降順' do
          before do
            visit admin_users_path
            click_link nil, id: 'name_desc'
          end
          let(:expected_list) { [login_user, user3, user2, user1] }
          it_behaves_like '期待した順番で表示されること'
        end
      end

      describe 'メールアドレス' do
        let!(:login_user) { FactoryBot.create(:user, email: 'natsume@example.com') }
        let!(:user1) { FactoryBot.create(:user, email: 'tanuma@example.com') }
        let!(:user2) { FactoryBot.create(:user, email: 'taki@example.com') }
        let!(:user3) { FactoryBot.create(:user, email: 'nyanko@example.com') }
        context '昇順' do
          before do
            visit admin_users_path
            click_link nil, id: 'email_asc'
          end
          let(:expected_list) { [login_user, user3, user2, user1] }
          it_behaves_like '期待した順番で表示されること'
        end
        context '降順' do
          before do
            visit admin_users_path
            click_link nil, id: 'email_desc'
          end
          let(:expected_list) { [user1, user2, user3, login_user] }
          it_behaves_like '期待した順番で表示されること'
        end
      end

      describe 'タスク数' do
        let!(:login_user) { FactoryBot.create(:user, email: 'natsume@example.com') }
        let!(:user1) { FactoryBot.create(:user, email: 'tanuma@example.com') }
        let!(:user2) { FactoryBot.create(:user, email: 'taki@example.com') }
        let!(:user3) { FactoryBot.create(:user, email: 'nyanko@example.com') }
        let!(:task1) { FactoryBot.create(:task, user: login_user) }
        let!(:task2) { FactoryBot.create(:task, user: user1) }
        let!(:task3) { FactoryBot.create(:task, user: user2) }
        let!(:task4) { FactoryBot.create(:task, user: user2) }
        context '昇順' do
          before do
            visit admin_users_path
            click_link nil, id: 'tasks_count_asc'
          end
          let(:expected_list) { [user3, user1, login_user, user2] }
          it_behaves_like '期待した順番で表示されること'
        end
        context '降順' do
          before do
            visit admin_users_path
            click_link nil, id: 'tasks_count_desc'
          end
          let(:expected_list) { [user2, user1, login_user, user3] }
          it_behaves_like '期待した順番で表示されること'
        end
      end

      describe '作成日時' do
        let!(:login_user) { FactoryBot.create(:user, email: 'natsume@example.com', created_at: Time.current + 4.days) }
        let!(:user1) { FactoryBot.create(:user, email: 'tanuma@example.com', created_at: Time.current + 1.day) }
        let!(:user2) { FactoryBot.create(:user, email: 'taki@example.com', created_at: Time.current + 3.days) }
        let!(:user3) { FactoryBot.create(:user, email: 'nyanko@example.com', created_at: Time.current + 2.days) }
        context '昇順' do
          before do
            visit admin_users_path
            click_link nil, id: 'created_at_asc'
          end
          let(:expected_list) { [user1, user3, user2, login_user] }
          it_behaves_like '期待した順番で表示されること'
        end
        context '降順' do
          before do
            visit admin_users_path
            click_link nil, id: 'created_at_desc'
          end
          let(:expected_list) { [login_user, user2, user3, user1] }
          it_behaves_like '期待した順番で表示されること'
        end
      end

      describe '更新日時' do
        let!(:login_user) { FactoryBot.create(:user, email: 'natsume@example.com', updated_at: Time.current + 4.days) }
        let!(:user1) { FactoryBot.create(:user, email: 'tanuma@example.com', updated_at: Time.current + 1.day) }
        let!(:user2) { FactoryBot.create(:user, email: 'taki@example.com', updated_at: Time.current + 3.days) }
        let!(:user3) { FactoryBot.create(:user, email: 'nyanko@example.com', updated_at: Time.current + 2.days) }
        context '昇順' do
          before do
            visit admin_users_path
            click_link nil, id: 'updated_at_asc'
          end
          let(:expected_list) { [user1, user3, user2, login_user] }
          it_behaves_like '期待した順番で表示されること'
        end
        context '降順' do
          before do
            visit admin_users_path
            click_link nil, id: 'updated_at_desc'
          end
          let(:expected_list) { [login_user, user2, user3, user1] }
          it_behaves_like '期待した順番で表示されること'
        end
      end
    end
  end
end
