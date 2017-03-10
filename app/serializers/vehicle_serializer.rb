class VehicleSerializer < ActiveModel::Serializer
  attributes :id, :brand, :model, :year
  has_one :user
end
