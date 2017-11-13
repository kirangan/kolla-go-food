FactoryGirl.define do
  factory :food_tag do
    association :food
    association :tag
  end
end