# frozen_string_literal: true

module Admin
  class BaseController < ApplicationController
    before_action :basic_auth
    
    private
    
    def basic_auth
      Rails.logger.info "Admin::BaseController#basic_auth called"
      authenticate_or_request_with_http_basic do |username, password|
        result = username == 'admin' && password == 'pw'
        Rails.logger.info "Authentication result: #{result}, Username: #{username}"
        result
      end
    end
  end
end
