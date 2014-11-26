require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module EdmundsChefRailsProxy
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    # config.time_zone = 'Central Time (US & Canada)'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    # config.i18n.default_locale = :de

    config.assets.paths << Rails.root.join("lib", "assets")

    config.assets.paths << Rails.root.join("lib", "assets", "bower_components", "bootstrap-sass-official", "assets", "stylesheets")
    config.assets.paths << Rails.root.join("lib", "assets", "bower_components", "bootstrap-sass-official", "assets", "fonts")
    # Precompile Bootstrap fonts
    config.assets.precompile << %r(bootstrap/[\w-]+\.(?:eot|svg|ttf|woff)$)
    # Minimum Sass number precision required by bootstrap-sass
    ::Sass::Script::Number.precision = [10, ::Sass::Script::Number.precision].max

    config.assets.paths << Rails.root.join("app", "assets", "fonts", "lato")
    config.assets.paths << Rails.root.join("app", "assets", "fonts", "glyphicons")
    # Precompile FlatUI fonts
    config.assets.precompile += %w( .svg .eot .woff .ttf)

  end
end
