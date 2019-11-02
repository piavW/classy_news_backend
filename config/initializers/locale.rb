I18n.load_path += Dir[Rails.root.join('initializers', 'locale', '*.{rb,yml}')]
#unsure of 'initializers'

I18n.available_locales = [:en, :sv]
 
I18n.default_locale = :en