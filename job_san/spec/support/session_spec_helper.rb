# frozen_string_literal: true

def login_as(user)
  allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
end

RSpec.shared_context 'when login required' do
  let!(:login_user) { create(:user) }
  before { login_as(login_user) }
end

RSpec.configure do |config|
  config.include_context 'when login required', :require_login
end
