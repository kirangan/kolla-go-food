FactoryGirl.define do
	factory :buyer do
		name { Faker::Superhero.name }
		email { Faker::Internet.email }
		phone { Faker::Number.number(12) }
		address { Faker::Address.street_name }
	end

	factory :invalid_buyer, parent: :buyer do 
		name nil
		email nil
		phone nil
		address nil
	end
end
