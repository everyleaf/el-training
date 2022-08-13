module LoginSupport
  def login_as(user)
    visit login_path
    fill_in 'session_email', with: user.email
    fill_in 'session_password', with: user.password
    click_on 'Log in'
  end
end

RSpec.configure do |config|
  config.include LoginSupport
end
