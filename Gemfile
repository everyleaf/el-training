source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.1.2'

# パスワードのハッシュ化関数を提供
gem 'bcrypt'

# Bundle edge Rails instead: gem "rails", github: "rails/rails", branch: "main"
gem 'rails', '~> 7.0.2', '>= 7.0.2.3'

gem 'bootstrap-sass', '3.4.1'

# The original asset pipeline for Rails [https://github.com/rails/sprockets-rails]
gem 'sprockets-rails'

# Use postgresql as the database for Active Record
gem 'pg'

# Use the Puma web server [https://github.com/puma/puma]
gem 'puma', '~> 5.0'

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: %i(mingw mswin x64_mingw jruby)

gem 'enum_help'

# javascriptでconfirmメッセージを出すのに使用
gem 'importmap-rails', '~> 1.1'
gem 'turbo-rails'

gem 'rails-i18n'

# ページネーション
gem 'kaminari'

group :development, :test do
  # See https://guides.rubyonrails.org/debugging_rails_applications.html#debugging-with-the-debug-gem
  gem 'debug', platforms: %i(mri mingw x64_mingw)
  gem 'factory_bot_rails'
  gem 'pry-byebug'
  gem 'rspec-rails'

  # Capybara本体
  gem 'capybara'
  # Capybaraが利用するドライバ
  gem 'selenium-webdriver'
end

group :development do
  # Speed up commands on slow machines / big apps [https://github.com/rails/spring]
  # gem "spring"
  gem 'retrieva-cop', require: false
end

group :test do
  gem 'database_cleaner'
end
