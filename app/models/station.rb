class Station
	include ActiveModel::Dirty

	define_attribute_methods :direccion, :distancia, :nombre, 
  :latitud, :longitud, :id, :precios, :tiempo, :pasos, :gastoaproximado,
  :precio_hardcode

	  def initialize(h)
    	h.each {|k,v| public_send("#{k}=",v)}
  	end

    def precio_hardcode
      @precio_hardcode
    end

    def precio_hardcode=(value)
      @precio_hardcode = value
    end


    def gastoaproximado
      @gastoaproximado
    end

    def gastoaproximado=(value)
      @gastoaproximado = gastoaproximado
    end

    def tiempo
      @tiempo
    end

    def tiempo=(value)
      @tiempo = tiempo
    end

    def pasos
      @pasos
    end

    def pasos=(value)
      @pasos = pasos
    end

    def precios
      @precios
    end

    def precios=(value)
      @precios = precios
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