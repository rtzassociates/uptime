FactoryGirl.define do 
  factory :event do |f|
    problem_attributes { attributes_for(:problem) } 
    status
  end
end
