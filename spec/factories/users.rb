FactoryGirl.define do
  factory :user do |f|
    f.sequence(:username) { |n| "foo#{n}" }
    f.sequence(:email_address) { |n| "foo#{n}@example.com" }
    f.time_zone "UTC"
    f.admin false
    f.password "secret"
    f.password_confirmation "secret"
  end
end
