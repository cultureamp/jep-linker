FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "test#{n}@example.com" }
    password "password"
    trait :with_token do
      token { SecureRandom.hex(16) }
    end
  end
end
