# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :database_server do
    name "MyString"
    description "MyText"
    deployed_at "2013-11-01 10:48:50"
  end
end
