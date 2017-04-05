class WelcomeController < ApplicationController

	def index
		@lat = request.location.latitude.to_s
	  	@long = request.location.longitude.to_s
	  	Rails.logger.debug("Usuario: "+@lat)
	end

end
