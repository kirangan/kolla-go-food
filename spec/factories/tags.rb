FactoryGirl.define do
  factory :tag do
    sequence :name do |n|
      "tag#{n}"
  end
end

  factory :invalid_tag, parent: :tag do
    name nil
  end
end