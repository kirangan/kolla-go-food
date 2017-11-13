FactoryGirl.define do
  factory :restaurant do
    name { Faker::Company.name }
    address { Faker::Address.street_address }
  end

  factory :invalid_restaurant, parent: :restaurant do
    name nil
    address nil
  end
end