require "spec_helper"

describe "events#_event" do
  
  let(:user) { FactoryGirl.create(:user) }
  
  context "with an unresolved event" do

    before(:each) do
      login user
      @event = FactoryGirl.create(:event)
      visit events_path
    end

    it "displays the status" do
      expect(page).to have_content @event.status.value
    end

    it "has a link to view the event" do
      expect(page).to have_link("View this event")
    end

    context "with no comments" do

      it "has a comment count of 0" do
        expect(page).to have_content("0 comments")
      end

    end

    context "with 1 comment" do

      before(:each) do
        @event.problem.comments.create(:user_id => user.id, :content => "Test content")
        @event.save
        visit events_path
      end

      it "has a comment count of 1" do
        expect(page).to have_content("1 comment")
      end

    end
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
