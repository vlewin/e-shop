require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

LANGUAGES = {
  de: 'Deutsch',
  ru: 'Русский'
}

module EShop
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
    config.autoload_paths += Dir[Rails.root.join('app', 'models', '{**}')]

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    config.time_zone = 'Berlin'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('config', 'locales', '**', '*.{rb,yml}')]
    config.i18n.load_path += Dir["#{Rails.root.to_s}/config/locales/**/*.yml"]
    config.i18n.locale = :de
    config.i18n.default_locale = :de
    config.i18n.available_locales = [:en, :de, :ru ]
    config.i18n.fallbacks = [config.i18n.available_locales]
    config.gettext_i18n_rails.default_options = ['--sort-by-msgid', '--no-wrap']

    # Should be set to true in production.
    config.less.compress = false
    config.less.paths << File.join(Rails.root, 'app', 'assets', 'stylesheets')

    # Do not swallow errors in after_commit/after_rollback callbacks.
    config.active_record.raise_in_transactional_callbacks = true

    config.active_record.schema_format = :ruby

    config.generators do |g|
      g.helper false
      g.stylesheets false
      g.assets false
      g.view_specs true
      g.template_engine :haml
      g.test_framework :rspec
      g.fixture_replacement :factory_girl
    end
  end
end


### Application localization
# Don't raise an InvalidLocale exception when the passed locale is not available
I18n.config.enforce_available_locales = false

# FastGettext settings
FastGettext.add_text_domain 'app', path: 'locale', type: :po
FastGettext.default_available_locales = Rails.application.config.i18n.available_locales
FastGettext.default_text_domain = 'app'
