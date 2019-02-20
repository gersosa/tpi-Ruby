class Question < ApplicationRecord
	validates_presence_of :title, :description
	belongs_to :user, optional: true
	has_many :answers, dependent: :delete_all
end
