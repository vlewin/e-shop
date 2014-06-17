source 'https://rubygems.org'
ruby '2.0.0'

gem 'rails', '~> 4.1.2.rc2'
gem 'puma'
gem 'pundit'
gem 'devise'

gem 'turbolinks'
gem 'jquery-turbolinks'

gem 'uglifier'
gem "therubyracer"

gem 'jquery-rails'
gem 'slim-rails'
gem 'less-rails'

gem 'less-rails-bootstrap'
gem 'font-awesome-less'

gem 'breadcrumbs_on_rails'
gem 'nested_form' # Check for alternatives
gem 'prawn'

# Search, filtering and pagination
gem 'ransack'
gem 'kaminari'
gem 'kaminari-bootstrap', '~> 3.0.1'

# Image uploads
gem 'carrierwave'
gem 'cloudinary'
gem 'rmagick'

group :development, :test do
  gem 'sqlite3'
  gem 'awesome_print'
  gem 'factory_girl_rails'
  gem 'ffaker'
  gem 'rspec-rails', '~> 3.0.0'
  gem 'debugger' if RUBY_PLATFORM =~ /linux/i
end

group :development do
  gem 'heroku'
  gem 'better_errors'
  gem 'binding_of_caller', platforms: [:mri_19, :mri_20, :rbx]
  gem 'quiet_assets'
  gem 'rails_layout'
end

group :test do
  gem 'database_cleaner'
  gem 'launchy'
end

group :production do
  gem 'rails_12factor'
  gem 'pg'
end
