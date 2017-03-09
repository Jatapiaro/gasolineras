class User < ApplicationRecord

	has_many :authentication_tokens

	devise :database_authenticatable, :registerable, :recoverable, 
	       :rememberable, :trackable, :validatable, :token_authenticatable

	validates :name, presence: true, length: {minimum: 3}
	validates :last_name, presence: true, length: {minimum: 3}
	validates :second_last_name, presence: true, length: {minimum: 3}


end
