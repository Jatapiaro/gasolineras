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
		  	tu = Station.new()
		  	tu.id = '-1'
		  	tu.longitud = @long
		  	tu.latitud = @lat
		  	tu.nombre = "Tu ubicación"
		  	@stations.push(tu)
		  	data.each { |x| @stations.push(Station.new(x))}

		  	@hash = Gmaps4rails.build_markers(@stations) do |s, marker|
	 			marker.lat s.latitud
	  			marker.lng s.longitud
	  			marker.title s.nombre
	  			marker.picture ({
    				url: "http://maps.google.com/mapfiles/kml/pal2/icon21.png",
				    width: 32,
				    height: 32,
				})
			end			
		end
	  	Rails.logger.debug("Usuario: "+data[0].to_s)
	end



end
