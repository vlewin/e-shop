source 'https://rubygems.org'
ruby '2.0.0'

gem 'rails', '4.1.0.rc1'
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
gem 'prawn'

# Search, filtering and pagination
gem 'ransack'
gem 'kaminari'
gem 'kaminari-bootstrap', '~> 3.0.1'

gem 'ffaker'

# Image uploads
gem 'carrierwave'
gem 'cloudinary'
gem 'rmagick'

gem 'heroku'

group :development, :test do
  gem 'sqlite3'
  gem 'awesome_print'
  gem 'factory_girl_rails'
  gem 'debugger' if RUBY_PLATFORM =~ /linux/i
end

group :development do
  gem 'better_errors'
  gem 'binding_of_caller', platforms: [:mri_19, :mri_20, :rbx]
  gem 'quiet_assets'
  gem 'rails_layout'
end

group :test do
  gem 'database_cleaner', '1.0.1'
  gem 'launchy'
  gem 'rspec-rails'
end

group :production do
  gem 'rails_12factor'
  gem 'pg'
end
