FactoryGirl.define do
  factory :category do
    sequence :name do |n|
      "category#{n}"
    end
  end

  factory :invalid_category, parent: :category do
    name nil
  end
end