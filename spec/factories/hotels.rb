FactoryGirl.define do

  factory :hotel do
    title { Faker::Lorem.word }
    rating { rand(6) }
    address { Address.create(country: Faker::Lorem.word) }
  end

end