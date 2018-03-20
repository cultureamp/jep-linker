FactoryBot.define do
  factory :user do
    email 'test@example.com'
    password 'f4k3p455w0rd'
    password_confirmation 'f4k3p455w0rd'
  end
end
