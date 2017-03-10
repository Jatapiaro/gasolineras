class CreateVehicles < ActiveRecord::Migration[5.0]
  def change
    create_table :vehicles do |t|
      t.references :user, foreign_key: true
      t.string :brand
      t.string :model
      t.integer :year

      t.timestamps
    end
  end
end
