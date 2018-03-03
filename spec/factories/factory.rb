FactoryBot.define do
  factory :user do
    email    "jasmine@cultureamp.com"
    password "password"
  end

  factory :link do
    long_url "https://cultureamp.com/"
  end

  factory :custom_link, class: Link do
    long_url  "https://github.com/"
    short_url "github"
  end
end
