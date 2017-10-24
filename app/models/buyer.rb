class Buyer < ApplicationRecord
	validates :name, :phone, :email, :address, presence: true
	validates :email, uniqueness: true, format: {
		with: /\A([\w+\-]\.?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i,
		message: 'must be valid email format'
	}
	validates :phone, format: { 
		with: /\d{12}/,
		message: 'phone format is invalid'
	}
end
