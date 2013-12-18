FactoryGirl.define do 

  factory :database do
    sequence(:name) { |n| "database#{n}" }
    database_server { FactoryGirl.create(:database_server) }
  end

end
