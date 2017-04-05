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

	  	stations = Array.new

	  	var = HTTParty.get(url+"/"+key+"/"+@lat+"/"+@long)
	  	data = var.parsed_response["gasolineras"]
	  	data.each { |x| stations.push(Station.new(x))}
	  	##
	  	Rails.logger.debug("Usuario: "+stations[0].to_s)
	end

end
