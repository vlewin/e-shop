source 'https://rubygems.org'
ruby '2.0.0'

gem 'rails', '4.1.0.rc1'
gem 'sqlite3'
gem 'puma'
gem 'pundit'
gem 'devise'

gem 'turbolinks'
gem 'jquery-turbolinks'

gem 'jquery-rails'
gem 'slim-rails'
gem 'less-rails'

gem 'less-rails-bootstrap'
gem 'font-awesome-less'

gem 'uglifier', '>= 1.3.0'
gem 'therubyracer', platform: :ruby

gem 'breadcrumbs_on_rails'
gem 'nested_form' # Check for alternatives

# Search, filtering and pagination
gem 'ransack'

group :production do
  # gem 'pg' # Heroku
end

group :development do
  gem 'better_errors'
  gem 'binding_of_caller', platforms: [:mri_19, :mri_20, :rbx]
  gem 'foreman'
  gem 'quiet_assets'
  gem 'rails_layout'
end

group :development, :test do
  gem 'awesome_print'
  gem 'factory_girl_rails'
  gem 'debugger' if RUBY_PLATFORM =~ /linux/i
  gem 'ffaker'
end

group :test do
  gem 'database_cleaner', '1.0.1'
  gem 'launchy'
  gem 'rspec-rails'
end

