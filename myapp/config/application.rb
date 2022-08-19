require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Myapp
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.0

    # タイムゾーン設定
    config.time_zone = 'Tokyo'

    # 日本語設定
    config.i18n.default_locale = :ja
    # ファイルパス設定
    config.i18n.load_path += Dir[Rails.root.join('path/to')]
    config.i18n.load_path += Dir[Rails.root.join('path/to', '**').to_s]
  end
end

