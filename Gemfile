source 'https://rubygems.org'
ruby '2.1.3'

gem 'rails', '~> 4.2.0'

# App localization
gem 'rails-i18n', '~> 4.0.0'
gem 'devise-i18n'
gem 'fast_gettext'
gem 'gettext_i18n_rails'
gem 'globalize'
gem 'globalize-accessors'
gem 'unicode'

gem 'puma'
gem 'uglifier'
gem 'therubyracer'

gem 'jquery-rails'
gem 'haml-rails'
gem 'less-rails'

gem 'less-rails-bootstrap'
gem 'font-awesome-less'

gem 'gretel'
gem 'prawn', require: false
gem 'prawn-table', require: false

# Authentication and authorization
gem 'devise'
gem 'devise_invitable'
gem 'pundit'

# Search, filtering and pagination
gem 'ransack'
gem 'kaminari'
gem 'kaminari-bootstrap', '~> 3.0.1'

# Image uploads
gem 'carrierwave'
gem 'cloudinary'
gem 'rmagick', require: false

gem 'settingslogic'

# FIXME: move to development/test group (used in seed.rb)
gem 'ffaker'
gem 'factory_girl_rails'

group :development, :test do
  gem 'sqlite3'
  gem 'awesome_print'
  gem 'byebug'
end

group :development do
  gem 'better_errors'
  gem 'quiet_assets'

  gem 'spring-commands-rspec', require: false
  gem 'heroku', require: false

  gem 'gettext', require: false
  gem 'ruby_parser', require: false
end

group :test do
  gem 'simplecov'
  gem 'codeclimate-test-reporter'
  gem 'rspec-rails', '~> 3.1'
  gem 'database_cleaner'
  gem 'shoulda-matchers', require: false
  gem 'launchy'
  gem 'timecop'
end

group :production do
  gem 'rails_12factor'
  gem 'newrelic_rpm'
  gem 'pg'
end
