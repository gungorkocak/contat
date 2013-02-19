require File.expand_path('../boot', __FILE__)

require 'rails/all'

if defined?(Bundler)
  Bundler.require(*Rails.groups(:assets => %w(development test)))
end

module Contat
  class Application < Rails::Application
    # config.autoload_paths += %W(#{config.root}/extras)

    # config.plugins = [ :exception_notification, :ssl_requirement, :all ]

    # config.time_zone = 'Central Time (US & Canada)'

    # config.i18n.default_locale = :de

    config.encoding = "utf-8"

    config.filter_parameters += [:password]

    config.active_support.escape_html_entities_in_json = true

    # config.active_record.schema_format = :sql

    config.active_record.whitelist_attributes = true

    config.assets.enabled = true

    config.assets.version = '1.0'

    config.generators do |g|
      g.fixture_replacement :factory_girl
      
      %w(view helper controller routing).each do |s|
        g.send("#{s}_specs".to_sym, false)
      end

    end
    config.assets.paths << "#{Rails.root}/vendor/assets/fonts"
  end
end
