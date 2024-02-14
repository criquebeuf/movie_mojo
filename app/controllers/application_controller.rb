class ApplicationController < ActionController::Base
  before_action :store_user_location!, if: :storable_location?
  def after_sign_in_path_for(resource_or_scope)
    stored_location_for(resource_or_scope) || super
  end

  def default_url_options
    { host: ENV["DOMAIN"] || "localhost:3000" }
  end

  private

  def storable_location?
    request.get? && is_navigational_format? && !devise_controller? && !request.xhr?
  end

  def store_user_location!
    store_location_for(:user, request.fullpath)
  end
end

# This is in case we need a username for a sign up page:

    #  before_action :configure_permitted_parameters, if: :devise_controller?


    #  private

    # def configure_permitted_parameters
    #    devise_parameters_sanitizer.permit(:sign_up, keys: [:username])
    #  end
