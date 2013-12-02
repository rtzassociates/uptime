FactoryGirl.define do 

  factory :database do
    name "test database"
    database_server { FactoryGirl.create(:database_server) }
  end

end
