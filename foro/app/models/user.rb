class User < ApplicationRecord
	validates :email, :username, uniqueness: true
	password (debe almacenarse hasheada, no puede ser almacenada en plano)
	screen_name
end
