FastGettext.add_text_domain 'app', path: 'locale', type: :po
FastGettext.default_available_locales = ['en','de', 'ru']
FastGettext.default_text_domain = 'app'

Rails.application.config.gettext_i18n_rails.default_options = ['--sort-by-msgid', '--no-wrap']
