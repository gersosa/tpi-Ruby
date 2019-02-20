FactoryBot.define do
  factory :answer do
    question
    content { Faker::Lorem.character }
    user
    created_at { Faker::Number.number(10) }
    updated_at { Faker::Number.number(10) }
  end
end

FactoryBot.define do
  factory :question do
    title { Faker::Lorem.character }
    description { Faker::Lorem.character }
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
    password 'foobar234423'
    screen_name { Faker::Lorem.characters(10) }
    sequence(:email) {|n| "user#{n}@mail.com" }
    created_at { Faker::Number.number(10) }
    updated_at { Faker::Number.number(10) }
  end
end