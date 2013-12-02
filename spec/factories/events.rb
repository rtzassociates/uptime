FactoryGirl.define do 

  factory :event do
    problem_attributes { attributes_for(:problem) }
    status { FactoryGirl.create(:status) }
  end
  
  factory :older_event, :class => Event do
    problem_attributes { attributes_for(:problem, reported_at_text: 2.days.ago.to_s) }
    status { FactoryGirl.create(:status) }
  end

  factory :newer_event, :class => Event  do
    problem_attributes { attributes_for(:problem, reported_at_text: 1.day.ago.to_s) }
    status { FactoryGirl.create(:status) }
  end

end
