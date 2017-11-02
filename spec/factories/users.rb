FactoryGirl.define do
  factory :user do
    username { Faker::Superhero.name }
    password 'longpassword'
    password_confirmation 'longpassword'

  end
end