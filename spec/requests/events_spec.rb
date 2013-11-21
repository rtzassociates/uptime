require "spec_helper"

describe "events#index" do
  
  let(:user) { FactoryGirl.create(:user) }
  let(:status) { FactoryGirl.build(:status).value }
  
  before do
    login user
    @event = FactoryGirl.create(:event)
  end
  
  it "should list events" do
    visit events_path
    page.should have_content( status )
  end
  
  it "should have a link to view the event" do
    visit events_path
    page.should have_link("View this event")
  end
  
  it "should display a count of the comments" do
    visit events_path
    page.should have_content("0 comments")
  end
  
  it "should update the comment count when a new comment is added" do
    comment = FactoryGirl.create(:comment)
    comment.commentable_id = @event.id
    comment.commentable_type = @event.class
    @event.problem.comments << comment
    visit events_path
    page.should have_content("1 comment")
  end
  
end

describe "events#new" do
  
  let(:user) { FactoryGirl.create(:user) }
  
  before do
    login user
    @status = FactoryGirl.create(:status)
  end
  
  it "should load the page" do
    visit new_event_path
    page.should have_content "New Event"
  end
  
  it "should let you create a new event" do
    visit new_event_path
    select @status.value, from: "event_status_id"
    fill_in "event_problem_attributes_reported_at_text", with: Time.now.to_s
    fill_in "event_problem_attributes_description", with: "Test description"
    click_button "Create Event"
    page.should have_content "Event was successfully created"
  end
  
end

describe "events#show" do
  
  let(:user) { FactoryGirl.create(:user) }
  
  before do
    login user
    @event = FactoryGirl.create(:event)
    @status = FactoryGirl.build(:status)
    visit event_path(@event)
  end
  
  it "should display the event status" do
    page.should have_content @status.value
  end
  
  it "should display a resolution link" do
    page.should have_link "Mark As Resolved"
  end
  
  it "should not display an edit link unless the user is an admin" do
    page.should_not have_link "Edit Problem"
  end
  
  it "should not display an destroy link unless the user is an admin" do
    page.should_not have_link "Delete Problem"
  end
  
  it "should display the problem description" do
    page.should have_content @event.problem.description
  end
  
end