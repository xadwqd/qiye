class Courier < ApplicationRecord
	has_and_belongs_to_many :stations
	belongs_to :city

	def to_s
		self.name
	end
end