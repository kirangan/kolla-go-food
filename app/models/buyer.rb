class Buyer < ApplicationRecord
	validates :name, :phone, :email, :address, presence: true
	validates :email, uniqueness: true, format: {
		with: /\A([\w+\-]\.?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i,
		message: 'must be valid email format'
	}
	validates :phone, numericality: true, length: { in: 9..12 } 

	def self.by_letter(letter)
		where("name LIKE ?", "#{letter}%").order(:name)
	end
end
