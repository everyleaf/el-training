# frozen_string_literal: true

require 'rails_helper'
require 'admin_helper'

RSpec.describe Label, js: true, type: :system do
  let(:login_user_email) { Faker::Internet.email }
  let(:login_user_password) { 'password' }

  context 'when login as a member' do
    let!(:login_user) { create(:user, email: login_user_email, password: login_user_password, password_confirmation: login_user_password) }
    before do
      visit login_path
      fill_in 'session_email', with: login_user.email
      fill_in 'session_password', with: login_user_password
      click_button 'ログイン'
    end

    it 'redirect to task list page' do
      visit admin_labels_path
      expect(current_path).to eq tasks_path
    end
  end

  context 'when not logged in yet' do
    it 'redirect to login' do
      visit admin_labels_path
      expect(current_path).to eq login_path
    end
  end

  let(:sample_label_name) { Faker::JapaneseMedia::Naruto.character }
  let!(:sample_label) { create(:label, name: sample_label_name) }

  describe '#index' do
    context 'when login as an admin' do
      include_context 'admin'

      before { visit admin_labels_path }

      it 'show labels' do
        label_ids = page.all('tbody td:first-child').map(&:text)
        expect(label_ids).to match_array(Label.all.pluck(:id).map(&:to_s))
      end

      context 'when users exist over 10' do
        before do
          create_list(:label, 10)
          visit admin_labels_path
        end

        it 'should show paginated labels' do
          label_ids = page.all('tbody td:first-child').map(&:text)
          expect(label_ids.count).to eq(10)
          click_on '次へ ›'
          # ページネーション処理が完了する前にテストコードが進んでしまうので、待機する。
          sleep(0.3)
          expect(page.all('tbody td:first-child').map(&:text)).not_to match_array(label_ids)
        end
      end

      context 'when search labels by a label_name' do
        let(:search_name) { Faker::JapaneseMedia::Naruto.character }
        let!(:filtered_labels) { (0..2).map { |_| create(:label, name: search_name + SecureRandom.uuid) } }
        before do
          fill_in 'ラベル名 は以下を含む', with: search_name[2..7]
        end

        it 'labels are filtered by partial matched name' do
          click_button '検索'
          # 検索処理が完了する前にテストコードが進んでしまうので、待機する。
          sleep(0.3)
          ids = page.all('tbody td:first-child').map(&:text)
          expect(ids).to match_array(filtered_labels.map { |t| t.id.to_s })
        end
      end
    end
  end

  describe '#new' do
    context 'when login as an admin' do
      include_context 'admin'

      before { visit new_admin_label_path }

      context 'submit valid values' do
        let(:create_label_name) { Faker::JapaneseMedia::OnePiece.character }

        before do
          fill_in 'ラベル名', with: create_label_name
        end

        subject { click_button '作成' }

        it 'move to label list page' do
          expect { subject }.to change { current_path }.from(new_admin_label_path).to(admin_labels_path)
          expect(page).to have_content 'ラベルを作成したよ'
        end

        it 'create new user' do
          expect {
            subject
            # 作成処理が完了する前に処理が進むのを防ぐ
            sleep(0.3)
          }.to change(Label.all, :count).by(1)
          created_label = Label.find_by(name: create_label_name)
          expect(created_label.name).to eq(create_label_name)
        end
      end
    end
  end

  describe '#edit' do
    context 'when login as an admin' do
      let(:update_label_name) { Faker::JapaneseMedia::OnePiece.character }

      subject { click_button '更新' }

      context 'submit valid values' do
        include_context 'admin'
        before do
          visit edit_admin_label_path id: sample_label.id
          fill_in 'ラベル名', with: update_label_name
        end

        it 'move to user list' do
          expect { subject }.to change {
            # 更新処理が完了する前にテストコードが進んでしまうので、待機する。
            sleep(0.3)
            current_path
          }.from(edit_admin_label_path(id: sample_label.id))
           .to(admin_labels_path)
          expect(page).to have_content 'ラベルを更新したよ'
        end

        it 'update selected label' do
          expect { subject }.to change {
            # 更新処理が完了する前にテストコードが進んでしまうので、待機する。
            sleep(0.3)
            sample_label.reload
            sample_label.name
          }.from(sample_label_name).to(update_label_name)
        end
      end
    end
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
          create_list(:label, 3)
          task = create(:task)
          task.labels << [sample_label]
          visit edit_admin_label_path(id: sample_label.id)
        end

        it 'move to label list page' do
          expect { subject }.to change { current_path }.from(edit_admin_label_path(id: sample_label.id)).to(admin_labels_path)
          expect(page).to have_content 'ラベルを削除したよ'
        end

        it 'delete selected label' do
          expect { subject }.to change {
            Label.count
          }.by(-1).and change {
            Label::TaskLabelRelation.count
          }.by(-1)
        end
      end
    end
  end
end
