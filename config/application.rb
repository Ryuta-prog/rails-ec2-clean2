# frozen_string_literal: true

require 'logger'

require_relative 'boot'

require 'rails/all'

require 'action_view/base'
require 'action_view/view_paths'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Myapp
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.0

    # Zeitwerkモード（デフォルト）
    config.autoloader = :zeitwerk

    # Please, add to the `ignore` list any other `lib` subdirectories that do
    # not contain `.rb` files, or that should not be reloaded or eager loaded.
    # Common ones are `templates`, `generators`, or `middleware`, for example.

    # config.autoload_lib(ignore: %w[assets tasks])

    # 国際化の設定
    config.i18n.default_locale = :ja
    config.i18n.available_locales = %i[ja en]
    config.i18n.load_path += Rails.root.glob('config/locales/**/*.{rb,yml}')

    # Active Storageの設定
    config.active_storage.variant_processor = :mini_magick
    config.active_storage.service = :amazon

    # タイムゾーンの設定
    config.time_zone = 'Tokyo'
    config.active_record.default_timezone = :local

    # ジェネレータの設定
    config.generators do |g|
      g.test_framework :rspec,
                       fixtures: true,
                       view_specs: false,
                       helper_specs: false,
                       routing_specs: false,
                       controller_specs: true,
                       request_specs: false
      g.fixture_replacement :factory_bot, dir: 'spec/factories'
    end

    # Action Mailerの設定
    # config.action_mailer.default_url_options = { host: 'localhost:3000' }
    config.action_mailer.default_url_options = { host: 'https://rails-ec2-cb8bc27b7188.herokuapp.com' }

    # エラーメッセージのフィールド囲みを削除
    config.action_view.field_error_proc = proc { |html_tag, _instance| html_tag }

    Rails.application.config.session_store :active_record_store, key: '_your_app_session'
  #下記を加えた
    Dotenv::Rails.load
  end
end
