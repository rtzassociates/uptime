FactoryGirl.define do
  factory :user do |f|
    f.sequence(:username) { |n| "foo#{n}" }
    f.time_zone "UTC"
    f.admin true
    f.password "secret"
    f.password_confirmation { |u| u.password }
  end
end
