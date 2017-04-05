class Station
	include ActiveModel::Dirty

	define_attribute_methods :direccion, :distancia, :nombre, :latitud, :longitud, :id

	def initialize(h)
    	h.each {|k,v| public_send("#{k}=",v)}
  	end
  	
  	def direccion=(value)
  	  @direccion = value
  	end

  	def distancia=(value)
  	  @distancia = value
  	end

  	def nombre=(value)
  	  @nombre = value
  	end

  	def latitud=(value)
  	  @latitud = value
  	end

  	def longitud=(value)
  	  @longitud = value
  	end

  	def id=(value)
  	  @id = value
  	end
  	
end