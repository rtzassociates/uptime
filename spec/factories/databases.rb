# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :database do
    name "MyString"
    server_id 1
  end
end
