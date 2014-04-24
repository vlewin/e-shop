require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

LANGUAGES = {
  :en => 'English',
  :de => 'Deutsch'
}

module OptimHandel
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    config.time_zone = 'Berlin'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    config.i18n.load_path += Dir[Rails.root.join('config', 'locales', '**', '*.{rb,yml}')]

    config.i18n.default_locale = :de
    # I18n.default_locale = :en
    config.enforce_available_locales = true

    config.less.paths << File.join(Rails.root, 'app', 'assets', 'stylesheets')

    # Should be set to true in production.
    config.less.compress = false

    config.generators do |g|
      g.helper false
      g.stylesheets false
      g.assets false
      g.view_specs false
      g.template_engine :slim
      g.test_framework :rspec
      g.fixture_replacement :factory_girl
    end
  end
end
