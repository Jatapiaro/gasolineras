class WelcomeController < ApplicationController



	def index
		url = "https://gasolineria.herokuapp.com/developer/estacionesSinCosto"
		key = "ViTThTQd9jLCSvFGZxNuDpRwFhhabalL"

		@lat
		@long
		if user_signed_in?
			##Hardcoding my ip
			if Rails.env.development?
				@lat = '19.2564776'
				@long = '-99.0184185'
		  	else
				@lat = request.location.latitude.to_s
		  		@long = request.location.longitude.to_s
		  	end

		  	@stations = Array.new

		  	var = HTTParty.get(url+"/"+key+"/"+@lat+"/"+@long)
		  	data = var.parsed_response["gasolineras"]
		  	data.each { |x| @stations.push(Station.new(x))}

		  	@hash = Gmaps4rails.build_markers(@stations) do |s, marker|
	 			marker.lat s.latitud
	  			marker.lng s.longitud
	  			marker.title s.nombre
			end			
		end
	  	##Rails.logger.debug("Usuario: "+stations[0].to_s)
	end

end
