module DMPonline4
  class Application < Rails::Application

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # Set the list of locales that we will support here (ie those for which we have translations for the DMPOnline application)
   # config.supported_locales = ['en', 'fr']
    # tell the I18n library where to find your translations
   # I18n.load_path += Dir[Rails.root.join('config', 'locales', '*.{rb,yml}').to_s]
    # set default locale
   # config.i18n.default_locale = :en
    
  end
end
