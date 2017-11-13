# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :review do
    name { Faker::Superhero.name }
    title { Faker::Movie.quote }
    description "MyText"
    reviewable_id 2
    reviewable_type 'Food'
  end

  factory :invalid_review, parent: :review do
    name nil
    title nil
    description nil
    reviewable_id nil
    reviewable_type nil
  end
end
