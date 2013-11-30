FactoryGirl.define do
  factory :resolution do |f|
    f.description "test description"
    f.resolved_at_text Time.now.to_s
    f.user_id { FactoryGirl.create(:user).id }
  end
end
