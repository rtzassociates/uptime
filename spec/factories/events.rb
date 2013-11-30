FactoryGirl.define do 

  factory :event do
    problem_attributes { attributes_for(:problem) }
    status { FactoryGirl.create(:status) }
  end

end
