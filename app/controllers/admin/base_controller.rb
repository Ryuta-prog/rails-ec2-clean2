# frozen_string_literal: true

class Admin::BaseController < ApplicationController
    before_action :authenticate

    private

    def authenticate
      authenticate_or_request_with_http_basic do |username, password|
        username == 'admin' && password == 'pw'
      end
    end
end
