FactoryGirl.define do
  factory :order do
    name { Faker::Name.name }
    address { Faker::Address.street_address }
    email { Faker::Internet.email }
    payment_type "Cash"
  end

  factory :invalid_order, parent: :order do
    name nil
    email nil
    address nil
    payment_type nil
  end 
end