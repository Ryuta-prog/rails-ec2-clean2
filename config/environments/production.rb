# frozen_string_literal: true

require 'active_support/core_ext/integer/time'

Rails.application.configure do
  # Settings specified here will take precedence over those in config/application.rb.

  config.public_file_server.enabled = ENV['RAILS_SERVE_STATIC_FILES'].present?

  # Code is not reloaded between requests.
  config.cache_classes = true

  # Eager load code on boot.
  config.eager_load = true

  # Full error reports are disabled and caching is turned on.
  config.consider_all_requests_local       = false
  config.action_controller.perform_caching = true

  # config.require_master_key = true

  config.assets.compile = false

  config.active_storage.service = :amazon
  config.active_storage.variant_processor = :mini_magick

  config.force_ssl = true
  config.session_store :active_record_store,
                       key: '_myapp_session',
                       secure: true,
                       same_site: :lax,
                       expire_after: 1.week

  config.log_level = :info
  config.log_tags = [:request_id]

  config.action_mailer.perform_caching = false
  config.action_mailer.default_options = {
    from: ENV.fetch('DEFAULT_FROM_EMAIL', 'longtaishangcun@gmail.com')
  }
  config.action_mailer.default_url_options = { host: ENV.fetch('APP_HOST', 'rails-ec2-0c3ad7f31a09.herokuapp.com') }
  config.action_mailer.delivery_method = :smtp
  config.action_mailer.smtp_settings = {
    address: ENV.fetch('SMTP_SERVER', nil),
    port: ENV.fetch('SMTP_PORT', nil),
    user_name: ENV.fetch('SMTP_USERNAME', nil),
    password: ENV.fetch('SMTP_PASSWORD', nil),
    authentication: :plain,
    enable_starttls_auto: true
  }
  config.action_mailer.raise_delivery_errors = true

  config.i18n.fallbacks = true
  config.active_support.report_deprecations = false
  config.log_formatter = Logger::Formatter.new

  # ログ出力を標準出力に設定（Heroku用）
  if ENV['RAILS_LOG_TO_STDOUT'].present?
    logger           = ActiveSupport::Logger.new($stdout)
    logger.formatter = config.log_formatter
    config.logger    = ActiveSupport::TaggedLogging.new(logger)
  end

  # Do not dump schema after migrations.
  config.active_record.dump_schema_after_migration = false
end
