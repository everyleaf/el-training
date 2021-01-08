# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UserService, type: :model do
  describe '#update_user' do
    let!(:sample_user) { create(:user, name: name, role_type: role) }
    let(:name) { 'ユーザ名' }
    let(:role) { 'admin' }
    let(:update_name) { '更新するユーザ名' }
    let(:update_role) { 'member' }
    let(:update_param) { { name: update_name, role_type: update_role } }

    context 'when there are some admins' do
      before { create_list(:user, 3, :with_admin) }
      let!(:login_user) { create(:user, :with_admin) }

      it 'should update the user' do
        service = UserService.new(sample_user, login_user)
        expect { service.update_user(update_param) }.to change {
          sample_user.reload
          sample_user.name
        }.from(name).to(update_name)
        .and change {
          sample_user.role_type
        }.from(role).to(update_role)
      end
    end

    context 'when update to unexpected role_type' do
      let(:update_role) { 'wrong_role' }
      let!(:login_user) { create(:user, :with_admin) }

      it 'should not be updated' do
        service = UserService.new(sample_user, login_user)
        expect(service.update_user(update_param).errors.full_messages).to eq(['ロールは不正な値です'])
      end
    end

    context 'when last admin' do
      context 'when update own role_type to member' do
        it 'should not be updated' do
          service = UserService.new(sample_user, sample_user)
          expect(service.update_user(update_param).errors.full_messages).to eq(['最後の管理者です'])
        end
      end

      context 'when update own name' do
        let(:update_param) { { name: update_name } }

        it 'should be updated' do
          service = UserService.new(sample_user, sample_user)
          expect { service.update_user(update_param) }.to change {
            sample_user.reload
            sample_user.name
          }.from(name).to(update_name)
        end
      end
    end
  end
end
