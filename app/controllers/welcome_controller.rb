class WelcomeController < ApplicationController



	def index
		##mOe7CawCpvO1Xn/19.2834775/-99.1352799
		url = "https://gasolineria.herokuapp.com/developer/estacionesSinCosto"
		key = "ViTThTQd9jLCSvFGZxNuDpRwFhhabalL"

		@lat
		@long

		##Hardcoding my ip
		if Rails.env.development?
			@lat = '19.2564776'
			@long = '-99.0184185'
	  	else
			@lat = request.location.latitude.to_s
	  		@long = request.location.longitude.to_s
	  	end

	  	var = HTTParty.get(url+"/"+key+"/"+@lat+"/"+@long)
	  	da = var.parsed_response["gasolineras"]
	  	Rails.logger.debug("Usuario: "+da.to_s)
	end

end
