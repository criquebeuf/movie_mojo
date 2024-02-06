class ApplicationController < ActionController::Base

# This is in case we need a username for a sign up page:

    #  before_action :configure_permitted_parameters, if: :devise_controller?


    #  private

    # def configure_permitted_parameters
    #    devise_parameters_sanitizer.permit(:sign_up, keys: [:username])
    #  end

end
