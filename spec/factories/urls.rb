FactoryGirl.define do
  factory :url do
    sequence(:name) { |n| "http://www#{n}.example.com" }
  end
end
