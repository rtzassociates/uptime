# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :ip_address do
    interface_id 1
    value "MyString"
  end
end
