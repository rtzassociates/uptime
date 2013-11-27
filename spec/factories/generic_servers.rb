FactoryGirl.define do
  factory :generic_server do |f|
    f.sequence(:name) { |n| "server#{n}" }
    f.deployed_at Time.now
    #f.server_type_id FactoryGirl.create(:server_type).id
    #f.server_location_id FactoryGirl.create(:server_location).id
    f.description "Test description."
    f.public_ip_address "127.0.0.1"
    #f.server_role_id FactoryGirl.create(:server_role).id
  end
end
