class Question < ApplicationRecord
	validates_presence_of :title, :description
	validates :status , confirmation: true
	belong_to :User:user_id (referencia a quién publicó la pregunta)
	answer_id (referencia a la respuesta que se marcó como correcta, en caso de estar resuelta)
	# created_at
	# updated_at
end
