class ApplicationController < ActionController::Base
  	 
    before_action :authenticate_user!, :do_not_set_cookie, if: -> { request.format.json? }
    before_action :configure_permitted_parameters, if: :devise_controller?

    ##http://stackoverflow.com/questions/40854937/new-error-while-upgrading-to-rails-5-nomethoderror-undefined-method-id-for/40872658#40872658
    protect_from_forgery unless: -> { request.format.json? }

    protected
    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: [:name,:last_name,:second_last_name])
      devise_parameter_sanitizer.permit(:account_update, keys: [:name,:last_name,:second_last_name])
    end

    private
    # Do not generate a session or session ID cookie
    # See https://github.com/rack/rack/blob/master/lib/rack/session/abstract/id.rb#L171
    def do_not_set_cookie
      puts "Estoy eliminando o saltandome las cookies"
      reset_session
    end

      def location
        if params[:location].blank?
          if Rails.env.test? || Rails.env.development?
            @location ||= Geocoder.search("50.78.167.161").first
          else
            @location ||= request.location
          end
        else
          params[:location].each {|l| l = l.to_i } if params[:location].is_a? Array
          @location ||= Geocoder.search(params[:location]).first
          allowed = [:latitude, :longitude, :address, :city]
          puts @location.methods
          @location
        end
      end

end
