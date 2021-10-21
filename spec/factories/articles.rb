FactoryBot.define do
  factory :article do
    association :user
    title { Faker::Lorem.sentence }
    content { Faker::Lorem.paragraph }
  end
end
