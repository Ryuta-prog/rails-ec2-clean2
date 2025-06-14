# frozen_string_literal: true

require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Myapp
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.0

    # 国際化設定
    config.i18n.default_locale = :ja
    config.i18n.available_locales = %i[ja en]
    config.i18n.load_path += Rails.root.glob('config/locales/**/*.{rb,yml}')

    config.active_storage.variant_processor = :vips
    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")
    config.action_view.form_with_generates_remote_forms = false
    config.assets.enabled = false
  end
end
