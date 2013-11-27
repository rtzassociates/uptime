FactoryGirl.define do
  factory :comment do |f|
    f.content "test comment"
    f.user_id { FactoryGirl.create(:user).id }
  end
end
