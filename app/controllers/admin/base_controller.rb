# frozen_string_literal: true

module Admin
  class BaseController < ApplicationController
    before_action :basic_auth

    private

    def basic_auth
      authenticate_or_request_with_http_basic do |username, password|
        username == ENV.fetch('ADMIN_USERNAME', 'admin') &&
          password == ENV.fetch('ADMIN_PASSWORD', 'pw')
      end
    end
  end
end
