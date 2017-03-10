class Vehicle < ApplicationRecord
  belongs_to :user

  validates :user, presence: true
  validates :brand, presence: true, length: {minimum: 3}
  validates :model, presence: true, length: {minimum: 3}
  validates :year, presence: true, length: {minimum: 4}

end
