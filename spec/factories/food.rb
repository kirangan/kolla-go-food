FactoryGirl.define do
	factory :food do
		name { Faker::Food.dish }
		description { Faker::Food.ingredient }
		image_url "Food.jpg"
		price 10000.0

		association :category
	end

	factory :invalid_food, parent: :food do 
		name nil
		description nil
		image_url "Food.html"
		price 0
	end
end
