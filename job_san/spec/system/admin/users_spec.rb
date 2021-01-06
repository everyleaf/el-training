# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, :require_login, js: true, type: :system do
  before do
    create_list(:task, 5, user: sample_user)
    build_list(:user, 5) { |user, i| create_list(:task, i, user: user) }
  end
  let(:sample_user_name) { Faker::JapaneseMedia::OnePiece.character }
  let(:sample_user_email) { Faker::Internet.email }
  let!(:sample_user) { create(:user, name: sample_user_name, email: sample_user_email) }

  describe '#index' do
    before { visit admin_users_path }

    it 'show all users' do
      user_ids = page.all('tbody td:first-child').map(&:text)
      expect(user_ids).to match_array(User.all.pluck(:id).map(&:to_s))
    end

    context 'when users exist over 10' do
      before do
        create_list(:user, 10)
        visit admin_users_path
      end

      it 'should show paginated users' do
        user_ids = page.all('tbody td:first-child').map(&:text)
        expect(user_ids.count).to eq(10)
        click_on '次へ ›'
        # ページネーション処理が完了する前にテストコードが進んでしまうので、待機する。
        sleep(0.3)
        expect(page.all('tbody td:first-child').map(&:text)).not_to match_array(user_ids)
      end
    end

    context 'when search users with a user_name' do
      let(:search_user_name) { SecureRandom.uuid }
      let!(:filtered_users) { create_list(:user, 3, name: search_user_name) }
      before do
        fill_in '名前 は以下を含む', with: search_user_name[2..7]
        click_button '検索'
        # 検索処理が完了する前にテストコードが進んでしまうので、待機する。
        sleep(0.3)
      end

      it 'users are filtered by partial matched name' do
        ids = page.all('tbody td:first-child').map(&:text)
        expect(ids).to match_array(filtered_users.map { |t| t.id.to_s })
      end
    end

    context 'when user does not login yet' do
      before do
        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(nil)
        visit admin_users_path
      end

      it 'render login page' do
        expect(current_path).to eq login_path
      end
    end
  end

  describe '#new' do
    before { visit new_admin_user_path }

    context 'submit valid values' do
      let(:create_user_name) { Faker::JapaneseMedia::OnePiece.character }
      let(:create_user_email) { Faker::Internet.email }
      let(:create_password) { 'これから作るユーザのpassword' }

      before do
        fill_in '名前', with: create_user_name
        fill_in 'Email', with: create_user_email
        fill_in 'パスワード', with: create_password
        fill_in 'パスワード確認', with: create_password
      end

      subject { click_button '作成' }

      it 'move to user list page' do
        subject
        expect(current_path).to eq admin_users_path
        expect(page).to have_content 'ユーザを作成したよ'
      end

      it 'create new user' do
        expect { subject }.to change(User.all, :count).by(1)
        # 作成処理が完了する前にテストコードが進んでしまうので、待機する。
        sleep(0.3)
        created_user = User.find_by(email: create_user_email)
        expect(created_user.name).to eq(create_user_name)
      end
    end

    context 'when user does not login yet' do
      before do
        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(nil)
        visit new_admin_user_path
      end

      it 'render login page' do
        expect(current_path).to eq login_path
      end
    end
  end

  describe '#edit' do
    before { visit edit_admin_user_path id: sample_user.id }
    let(:update_user_name) { Faker::JapaneseMedia::OnePiece.character }
    let(:update_user_email) { Faker::Internet.email }
    let(:update_password) { 'これから更新するユーザのpassword' }
    let(:updated_user) { User.find(sample_user.id) }

    context 'submit valid values' do
      before do
        fill_in '名前', with: update_user_name
        fill_in 'Email', with: update_user_email
      end

      subject { click_button '更新' }

      it 'move to updated user page' do
        expect { subject }.to change {
          current_path
        }.from(edit_admin_user_path(id: sample_user.id))
         .to(admin_users_path)
        expect(page).to have_content 'ユーザを更新したよ'
      end

      it 'update selected user' do
        expect { subject }.to change {
          # 更新処理が完了する前にテストコードが進んでしまうので、待機する。
          sleep(0.3)
          updated_user.reload
          updated_user.name
        }.from(sample_user_name).to(update_user_name)
          .and change {
            updated_user.email
          }.from(sample_user_email).to(update_user_email)
      end
    end

    context 'when user does not login yet' do
      before do
        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(nil)
        fill_in '名前', with: update_user_name
        fill_in 'Email', with: update_user_email
      end

      it 'render login page' do
        visit edit_admin_user_path id: sample_user.id
        expect(current_path).to eq login_path
      end

      it 'should not update selected user' do
        expect {
          subject
          updated_user.reload
        }.not_to change {
          [updated_user.name,
           updated_user.email]
        }
      end
    end
  end

  describe '#destroy' do
    before { visit edit_admin_user_path(id: sample_user.id) }

    subject do
      page.accept_confirm do
        click_on '削除'
      end
      # 削除処理が完了する前にテストコードが進んでしまうので、待機する。
      sleep 0.3
    end

    it 'move to user list page' do
      expect { subject }.to change { current_path }.from(edit_admin_user_path(id: sample_user.id)).to(admin_users_path)
      expect(page).to have_content 'ユーザを削除したよ'
    end

    it 'delete selected user' do
      expect { subject }.to change {
        User.count
      }.by(-1).and change {
        Task.count
      }.by(-sample_user.tasks.count)
    end

    context 'when user does not login yet' do
      before { allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(nil) }

      it 'render login page' do
        visit edit_admin_user_path(id: sample_user.id)
        expect(current_path).to eq login_path
      end

      it 'should not delete selected user' do
        expect { subject }.to change {
          User.count
        }.by(0).and change {
          Task.count
        }.by(0).and change {
          current_path
        }.from(edit_admin_user_path(id: sample_user.id)).to(login_path)
      end
    end
  end

  describe 'user_tasks' do
    before do
      create_list(:task, 3, user: sample_user)
      visit tasks_admin_user_path(id: sample_user.id)
    end

    it 'show only tasks of the selected user' do
      task_ids = sample_user.tasks.pluck(:id).map(&:to_s)
      expect(page.all('tbody td:first-child').map(&:text)).to match_array(task_ids)
    end

    context 'when user does not login yet' do
      before { allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(nil) }

      it 'render login page' do
        visit tasks_admin_user_path(id: sample_user.id)
        expect(current_path).to eq login_path
      end
    end
  end
end
