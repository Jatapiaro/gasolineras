class VehiclesController < ApplicationController

  before_action :set_vehicle, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!

  # GET /vehicles
  # GET /vehicles.json
  def index
    ##@user  = User.find_by(email: params[:email])
    @vehicles = current_user.vehicles
  end

  # GET /vehicles/1
  # GET /vehicles/1.json
  def show

    url = "https://gasolineria.herokuapp.com/developer/estacionesConsumo"
    key = "ViTThTQd9jLCSvFGZxNuDpRwFhhabalL"
   
    @lat
    @long

    if Rails.env.development?
      @lat = '19.2564776'
      @long = '-99.0184185'
    else
      @lat = request.location.latitude.to_s
      @long = request.location.longitude.to_s
    end

    @stations = Array.new

    var = HTTParty.get(url+"/"+key+"/"+@lat+"/"+@long+"/"+@vehicle.fuel_efficiency.to_s)
    data = var.parsed_response["gasolineras"]

    tu = Station.new({"nombre"=>"Tu ubicación", "direccion"=>"", "distancia"=>"0.0", "longitud"=>@long, "id"=>"-1", "latitud"=>@lat})
    @stations.push(tu)

    ##Rails.logger.debug("Gas: "+data[0]['precios'].to_s) 

    data.each do |x| 
      s = Station.new(x)
      precios = ''
      x['precios'].each do |k,v|
        ##Rails.logger.debug(k.to_s+": $"+v.to_s)
        precios+=(k.to_s+": $"+v.to_s)+" "
      end
      s.precio_hardcode = precios
      Rails.logger.debug(s.precio_hardcode) 
      @stations.push(s)
    end
    
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
        marker.infowindow  s.direccion + " A "+s.distancia.to_s+" km de distancia, sus precios son "+s.precio_hardcode

      end
    end

    #Rails.logger.debug("Gas: "+@stations.to_s)
  end

  # GET /vehicles/new
  def new
    @vehicle = Vehicle.new
  end

  # GET /vehicles/1/edit
  def edit
  end

  # POST /vehicles
  # POST /vehicles.json
  def create


    @vehicle = current_user.vehicles.new(vehicle_params)

    respond_to do |format|
      if @vehicle.save
        format.html { redirect_to @vehicle, notice: 'El vehículo fue creado.' }
        format.json { render :show, status: :created, location: @vehicle }
      else
        format.html { render :new }
        format.json { render json: @vehicle.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /vehicles/1
  # PATCH/PUT /vehicles/1.json
  def update
    respond_to do |format|
      if @vehicle.update(vehicle_params)
        format.html { redirect_to @vehicle, notice: 'El vehículo fue actualizado.' }
        format.json { render :show, status: :ok, location: @vehicle }
      else
        format.html { render :edit }
        format.json { render json: @vehicle.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /vehicles/1
  # DELETE /vehicles/1.json
  def destroy
    @vehicle.destroy
    respond_to do |format|
      format.html { redirect_to vehicles_url, notice: 'El vehículo fue eliminado.' }
      format.json { head :no_content }
    end
  end

  private

    # Use callbacks to share common setup or constraints between actions.
    def set_vehicle
      @vehicle = Vehicle.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def vehicle_params
      params.require(:vehicle).permit(:user_id, :brand, :model, :year, :fuel_efficiency)
    end

    def validate_user
      redirect_to new_user_session_path, notice: "Necesitas inicar sesión"
    end

end
