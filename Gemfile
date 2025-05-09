# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.1.4'

gem 'activerecord-session_store', '~> 2.1'
gem 'aws-sdk-rails'
gem 'aws-sdk-s3', '~> 1.183', require: false
gem 'bootsnap', require: false
gem 'bootstrap', '~> 5.3.3'
gem 'concurrent-ruby', '~> 1.3.4'
gem 'cssbundling-rails'
gem 'devise', '~> 4.9.2'
gem 'devise-i18n', '~> 1.13.0'
gem 'faraday'
gem 'foreman'
gem 'image_processing', '~> 1.2'
gem 'jbuilder'
gem 'jp_prefecture'
gem 'jsbundling-rails'
gem 'pg', '~> 1.5'
gem 'puma', '~> 6.5.0'
gem 'rack-cors', '~> 2.0', '>= 2.0.2'
gem 'rails', '~> 7.0.8'
gem 'rubocop-capybara', require: false
gem 'rubocop-factory_bot', require: false
gem 'ruby-vips', '~> 2.1.0'
gem 'rubyzip'
gem 'sassc-rails'
gem 'sidekiq'
gem 'stimulus-rails'
gem 'turbo-rails'
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]

group :development, :test do
  gem 'debug', platforms: %i[mri mingw x64_mingw]
  gem 'dotenv-rails'
  gem 'factory_bot_rails'
  gem 'rspec-rails'
end

group :development do
  gem 'htmlbeautifier'
  gem 'rails_best_practices'
  gem 'rubocop', '~> 1.75.3', require: false
  gem 'rubocop-rails', '~> 2.20', require: false
  gem 'rubocop-rspec', '~> 3.5.0', require: false
  gem 'squasher'
  gem 'web-console'
end

group :test do
  gem 'capybara'
  gem 'selenium-webdriver'
  gem 'webdrivers'
end
