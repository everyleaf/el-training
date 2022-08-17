require 'rails_helper'

RSpec.describe UserMailer, type: :mailer do
  describe 'アカウント有効化メール' do
    let(:user) { create(:user) }
    let(:mail) { UserMailer.account_activation(user) }

    it '宛先が正常である' do
      expect(mail.subject).to eq(I18n.t 'account_authentication')
      expect(mail.to).to eq([user.email])
      expect(mail.from).to eq(['from@example.com'])
    end

    it 'アクティベーショントークンが含まれている' do
      expect(mail.html_part.body.to_s).to include(user.activation_token)
    end
  end
end
