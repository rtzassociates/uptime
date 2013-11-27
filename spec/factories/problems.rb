FactoryGirl.define do
  factory :problem do |f|
    f.description "test description"
    f.reported_at_text Time.now.to_s
    f.user_id { FactoryGirl.create(:user).id }
  end
end
