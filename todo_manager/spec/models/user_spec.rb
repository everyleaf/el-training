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
  end

  describe 'authenticate' do
    it 'should be authenticated by bcrypt' do
      user = User.new(password: 'fuga')
      expect(user.authenticate('fuga')).not_to be false
    end
  end
end
