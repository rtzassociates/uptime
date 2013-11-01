# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :server do
    name "MyString"
    description "MyText"
    deployed_at "2013-11-01 09:38:34"
  end
end
