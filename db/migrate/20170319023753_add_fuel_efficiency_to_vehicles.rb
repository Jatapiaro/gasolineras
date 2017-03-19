class AddFuelEfficiencyToVehicles < ActiveRecord::Migration[5.0]
  def change
    add_column :vehicles, :fuel_efficiency, :integer
  end
end
