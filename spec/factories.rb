FactoryGirl.define do

  factory :user do |f|
    f.sequence(:username) { |n| "foo#{n}" }
    f.time_zone "UTC"
    f.admin false
    f.password "secret"
    f.password_confirmation { |u| u.password }
  end
  
  factory :problem do |f|
    f.description "test description"
    f.reported_at_text Time.now.to_s
    f.user_id { FactoryGirl.create(:user).id }
  end
  
  factory :status do |f|
    f.value "Outage"
    f.text_color "black"
  end
  
  factory :event do |f|
    problem_attributes { attributes_for(:problem) } 
    status
  end
  
  factory :comment do |f|
    f.content "test comment"
    f.user_id { FactoryGirl.create(:user).id }
  end
  
end
