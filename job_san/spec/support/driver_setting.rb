# @legacy: ローカルで確認したいときに役に立つので、残しておきます。
#
# RSpec.configure do |config|
#   config.before(:each, type: :system) do
#     # For opening browser
#     # driven_by(:selenium_chrome)
#
#     # For non-opening browser
#     driven_by :selenium_chrome_headless, options: { desired_capabilities: %w[headless disable-gpu no-sandbox disable-dev-shm-usage window-size=1680,1050] }
#   end
# end
