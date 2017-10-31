FactoryGirl.define do
  factory :drink do
    name { Faker::Coffee.blend_name }
    description { Faker::Coffee.notes }
    image_url "http://www.resepharian.com/wp-content/uploads/2015/06/Resep-Membuat-Es-Soda-Gembira-Segar-Sederhana.jpg"
    price 10000.0
  end

  factory :invalid_drink, parent: :drink do
    name nil
    description nil
    image_url "http://www.resepharian.com/wp-content/uploads/2015/06/Resep-Membuat-Es-Soda-Gembira-Segar-Sederhana.html"
    price 10000.0
  end
end