
RSpec.configure do |config|
  config.before(:each, type: :system) do
    # For opening browser
    # driven_by(:selenium_chrome)

    # For non-opening browser
    driven_by(:selenium_chrome_headless)
  end
end
