# frozen_string_literal: true

class RegistrationsController < Devise::RegistrationsController
  def create
    build_resource(sign_up_params)
    resource.save
    yield resource if block_given?
    resource.persisted? ? handle_success : handle_failure
  end

  private

  def handle_success
    if resource.active_for_authentication?
      handle_active_user
    else
      handle_inactive_user
    end
  end

  def handle_active_user
    set_flash_message! :notice, :signed_up
    sign_up(resource_name, resource)
    respond_with resource, location: after_sign_up_path_for(resource)
  end

  def handle_inactive_user
    set_flash_message! :notice, :"signed_up_but_#{resource.inactive_message}"
    expire_data_after_sign_in!
    respond_with resource, location: after_inactive_sign_up_path_for(resource)
  end

  def handle_failure
    clean_up_passwords resource
    set_minimum_password_length
    flash[:error] = resource.errors.full_messages.join(', ')
    redirect_to new_user_registration_path
  end

  def sign_up_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end
end
