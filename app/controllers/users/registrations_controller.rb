# frozen_string_literal: true

module Users
  class RegistrationsController < Devise::RegistrationsController
    # POST /resource

    # PUT /resource

    protected

    # Rails 7 + Turbo対応: バリデーションエラー時に422 Unprocessable Entityを返す
    def respond_with(resource, opts = {})
      super(resource, opts.merge(status: :unprocessable_entity))
    end
  end
end
