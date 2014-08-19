FactoryGirl.define do

  factory :hotel do
    title { Faker::Lorem.word }
    rating { rand(6) }
  end

end