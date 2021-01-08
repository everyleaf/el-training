# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, js: true, type: :system do
  let(:login_user_email) { Faker::Internet.email }
  let(:login_user_password) { 'password' }

  shared_context 'admin' do
    let!(:login_user) { create(:user, :with_admin, email: login_user_email, password: login_user_password, password_confirmation: login_user_password) }
    before do
      visit login_path
      fill_in 'session_email', with: login_user.email
      fill_in 'session_password', with: login_user_password
      click_button 'ログイン'
    end
  end

  shared_examples 'when login as a member' do
    let!(:login_user) { create(:user, email: login_user_email, password: login_user_password, password_confirmation: login_user_password) }
    before do
      visit login_path
      fill_in 'session_email', with: login_user.email
      fill_in 'session_password', with: login_user_password
      click_button 'ログイン'
    end

    it 'redirect to task list page' do
      visit admin_users_path
      expect(current_path).to eq tasks_path
    end
  end

  shared_examples 'when not logged in yet' do
    it 'redirect to login' do
      visit admin_users_path
      expect(current_path).to eq login_path
    end
  end

  before do
    create_list(:task, 5, user: sample_user)
    build_list(:user, 5) { |user, i| create_list(:task, i, user: user) }
  end
  let(:sample_user_name) { Faker::JapaneseMedia::OnePiece.character }
  let(:sample_user_email) { Faker::Internet.email }
  let!(:sample_user) { create(:user, name: sample_user_name, email: sample_user_email) }

  describe '#index' do
    context 'when login as an admin' do
      include_context 'admin'

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

      context 'when search users by a user_name' do
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
    end

    it_behaves_like 'when login as a member'
    it_behaves_like 'when not logged in yet'
  end

  describe '#new' do
    context 'when login as an admin' do
      include_context 'admin'

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
          expect {
            subject
            # 作成処理が完了する前に処理が進むのを防ぐ
            sleep(0.3)
          }.to change(User.all, :count).by(1)
          created_user = User.find_by(email: create_user_email)
          expect(created_user.name).to eq(create_user_name)
        end
      end
    end

    it_behaves_like 'when login as a member'
    it_behaves_like 'when not logged in yet'
  end

  describe '#edit' do
    context 'when login as an admin' do
      let(:update_user_name) { Faker::JapaneseMedia::OnePiece.character }
      let(:update_user_email) { Faker::Internet.email }
      let(:update_password) { 'これから更新するユーザのpassword' }

      subject { click_button '更新' }

      context 'submit valid values' do
        include_context 'admin'
        before do
          visit edit_admin_user_path id: sample_user.id
          fill_in '名前', with: update_user_name
          fill_in 'Email', with: update_user_email
        end

        it 'move to user list' do
          expect { subject }.to change {
            # 更新処理が完了する前にテストコードが進んでしまうので、待機する。
            sleep(0.3)
            current_path
          }.from(edit_admin_user_path(id: sample_user.id))
           .to(admin_users_path)
          expect(page).to have_content 'ユーザを更新したよ'
        end

        it 'update selected user' do
          expect { subject }.to change {
            # 更新処理が完了する前にテストコードが進んでしまうので、待機する。
            sleep(0.3)
            sample_user.reload
            sample_user.name
          }.from(sample_user_name).to(update_user_name)
           .and change {
             sample_user.email
           }.from(sample_user_email).to(update_user_email)
        end
      end

      context 'when last admin' do
        let(:login_user_name) { Faker::JapaneseMedia::OnePiece.character }
        let!(:login_user) {
          create(:user,
                 :with_admin,
                 name: login_user_name,
                 email: login_user_email,
                 password: login_user_password,
                 password_confirmation: login_user_password)
        }
        before do
          visit login_path
          fill_in 'session_email', with: login_user.email
          fill_in 'session_password', with: login_user_password
          click_button 'ログイン'
        end

        # context 'when update own role_type to member' do
        #   it 'should not be updated' do
        #
        #   end
        # end

        context 'when update own name' do
          before do
            visit edit_admin_user_path id: login_user.id
            fill_in '名前', with: update_user_name
            fill_in 'Email', with: update_user_email
          end

          it 'update selected user' do
            expect { subject }.to change {
              # 更新処理が完了する前にテストコードが進んでしまうので、待機する。
              sleep(0.3)
              login_user.reload
              login_user.name
            }.from(login_user_name).to(update_user_name)
             .and change {
               login_user.email
             }.from(login_user_email).to(update_user_email)
          end
        end
      end
    end

    it_behaves_like 'when login as a member'
    it_behaves_like 'when not logged in yet'
  end

  describe '#destroy' do
    context 'when login as an admin' do
      subject do
        page.accept_confirm do
          click_on '削除'
        end
        # 削除処理が完了する前にテストコードが進んでしまうので、待機する。
        sleep 0.3
      end

      context 'when there are some admins' do
        include_context 'admin'

        before do
          create_list(:user, 3, :with_admin)
          visit edit_admin_user_path(id: sample_user.id)
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
      end
    end

    context 'when last admin' do
      let!(:login_user) { create(:user, :with_admin, email: login_user_email, password: login_user_password, password_confirmation: login_user_password) }
      before do
        visit login_path
        fill_in 'session_email', with: login_user.email
        fill_in 'session_password', with: login_user_password
        click_button 'ログイン'
        visit edit_admin_user_path id: login_user.id
      end

      it 'should not delete' do
        expect { subject }.to change { User.count }.by(0)
      end
    end

    it_behaves_like 'when login as a member'
    it_behaves_like 'when not logged in yet'
  end

  describe 'user_tasks' do
    context 'when login as an admin' do
      include_context 'admin'

      before do
        create_list(:task, 3, user: sample_user)
        visit tasks_admin_user_path(id: sample_user.id)
      end

      it 'show only tasks of the selected user' do
        task_ids = sample_user.tasks.pluck(:id).map(&:to_s)
        expect(page.all('tbody td:first-child').map(&:text)).to match_array(task_ids)
      end
    end

    it_behaves_like 'when login as a member'
    it_behaves_like 'when not logged in yet'
  end
end
