# frozen_string_literal: true

module Admin
  class BaseController < ApplicationController
    before_action :authenticate

    private

    def authenticate
      authenticate_or_request_with_http_basic do |username, password|
        username == 'admin' && password == 'pw'
      end
    end
  end
end
