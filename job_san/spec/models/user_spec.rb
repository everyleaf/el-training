# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'create a user' do
    let(:sample_password) { 'password' }

    it 'create a new user' do
      user = User.new(name: Faker::Name.name,
                      email: Faker::Internet.email,
                      password: sample_password,
                      password_confirmation: sample_password)
      expect(user.save).to be_truthy
    end

    context 'when email is invalid format' do
      let(:invalid_format_email) { 'fhijeaofenaf' }

      it 'should not create user' do
        user = User.new(name: Faker::Name.name,
                        email: invalid_format_email,
                        password: sample_password,
                        password_confirmation: sample_password)
        expect(user.save).to be_falsey
        expect(user.errors.full_messages).to eq(['Emailは不正な値です'])
      end
    end
  end

  describe '#authenticated?' do
    context 'when user has not logged in yet' do
      let!(:sample_user) { create(:user, remember_digest: nil, remember_token: nil) }

      it { expect(sample_user.authenticated?(nil)).to be_falsey }
    end
  end
end
