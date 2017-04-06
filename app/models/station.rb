class Station
	include ActiveModel::Dirty

	define_attribute_methods :direccion, :distancia, :nombre, :latitud, :longitud, :id

	  def initialize(h)
    	h.each {|k,v| public_send("#{k}=",v)}
  	end
  	
    def direccion
      @direccion
    end

  	def direccion=(value)
  	  @direccion = value
  	end

  	def distancia=(value)
  	  @distancia = value
  	end

    def distancia
      @distancia
    end

  	def nombre=(value)
  	  @nombre = value
  	end

    def nombre
      @nombre
    end

  	def latitud=(value)
  	  @latitud = value
  	end

    def latitud
      @latitud
    end

  	def longitud=(value)
  	  @longitud = value
  	end

    def longitud
      @longitud
    end

  	def id=(value)
  	  @id = value
  	end

    def id
      @id
    end
  	
end