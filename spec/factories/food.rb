FactoryGirl.define do
	factory :food do
		name "{ Faker::Food.dish }"
		description "Betawi style steamed rice cooked in coconut milk. Delicious!"
		price 10000.0
    image_url "https://i.imgur.com/lWNdCHS.jpg"
	end
end
