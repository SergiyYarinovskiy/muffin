FactoryGirl.define do

  factory :user do
    email { Faker::Lorem.word.concat('@mail.com') }
    password { (0...(rand(7)+8)).map { ('a'..'z').to_a[rand(26)] }.join }
  end

end