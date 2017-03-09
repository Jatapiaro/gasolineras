class ApplicationController < ActionController::Base
  	protect_from_forgery with: :null_session
    	##protect_from_forgery unless: -> { request.format.json? }

    # Require authentication and do not set a session cookie for JSON requests (API clients)
    ##before_action :authenticate_user!, :do_not_set_cookie, if: -> { request.format.json? }
    before_action :configure_permitted_parameters, if: :devise_controller?

    protected
    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: [:name,:last_name,:second_last_name])
      devise_parameter_sanitizer.permit(:account_update, keys: [:name,:last_name,:second_last_name])
    end

    private
    # Do not generate a session or session ID cookie
    # See https://github.com/rack/rack/blob/master/lib/rack/session/abstract/id.rb#L171
    def do_not_set_cookie
      request.session_options[:skip] = true
    end
end
