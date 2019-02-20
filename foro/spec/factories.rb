FactoryBot.define do
  factory :answer do
    question
    content { Faker::StarWars.character }
    user
    created_at { Faker::Number.number(10) }
    updated_at { Faker::Number.number(10) }
  end
end

FactoryBot.define do
  factory :question do
    title { Faker::StarWars.character }
    description { Faker::StarWars.character }
    status false
    user
    created_at { Faker::Number.number(10) }
    updated_at { Faker::Number.number(10) }
    after :question do |question|
      create :answer, question: question
    end
  end
end 

FactoryBot.define do
  factory :user do
    username { Faker::Lorem.characters(10) }
    password { Faker::Lorem.characters(10) }
    screen_name { Faker::Lorem.characters(10) }
    sequence(:email) {|n| "test#{n}@mail.com" }
    created_at { Faker::Number.number(10) }
    updated_at { Faker::Number.number(10) }
  end
end