require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validation' do
    describe 'name or password' do
      context 'is nil' do
        it "can't be created" do
          expect(User.new(name: '', password: 'fuga').valid?).to be false
          expect(User.new(name: 'hoge', password: '').valid?).to be false
        end
      end
    end

    describe 'name and password' do
      context 'are not nil' do
        it 'can be created' do
          expect(User.new(name: 'hoge', password: 'fuga').valid?).not_to be false
        end
      end
    end

    describe 'name' do
      it 'should be unique' do
        expect { create(:user, name: 'hoge', password: 'aaa') }.not_to raise_error
        expect { create(:user, name: 'hoge', password: 'bbb') }.to raise_error(ActiveRecord::RecordInvalid)
      end
    end
  end

  describe 'authenticate' do
    it 'should be authenticated by bcrypt' do
      user = User.new(password: 'fuga')
      expect(user.authenticate('fuga')).not_to be false
    end
  end
end
