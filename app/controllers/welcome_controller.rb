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
		  	tu = Station.new({"nombre"=>"Tu ubicación", "direccion"=>"", "distancia"=>"0.0", "longitud"=>@long, "id"=>"-1", "latitud"=>@lat})
		  	@stations.push(tu)
		  	data.each { |x| @stations.push(Station.new(x))}

		  	@hash = Gmaps4rails.build_markers(@stations) do |s, marker|
	 			marker.lat s.latitud
	  			marker.lng s.longitud
	  			marker.title s.nombre
	  			if s.id == '-1'
	  				marker.picture ({
	  				    url: "http://maps.google.com/mapfiles/ms/micons/man.png",
	  					width: 32,
	  					height: 32,
	  				})	
	  			else
	  				marker.picture ({
	  				    url: "http://maps.google.com/mapfiles/kml/pal2/icon21.png",
	  					width: 32,
	  					height: 32,
	  				}) 
	  				marker.infowindow  s.direccion + " A "+s.distancia+" km de distancia"				
	  			end
			end
			##Rails.logger.debug("Usuario: "+data[0].to_s)			
		end
	end


end
