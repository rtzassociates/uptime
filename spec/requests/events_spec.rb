require "spec_helper"

describe "events" do

  let(:user)  { FactoryGirl.create(:user) }
  let(:admin) { FactoryGirl.create(:admin) }

  before(:each) do
    @event = FactoryGirl.create(:event)
  end

  describe "GET /events/index" do

    context "as a user" do

      before(:each) do
        login user
        visit events_path
      end

      it "has a link to create an event" do
        expect(page).to have_link "Create a new event"
      end
    
    end

  end

  describe "_event" do

    context "as a user" do

      before(:each) do
        login user
      end

      context "with an unresolved event" do

        before(:each) do
          @event = FactoryGirl.create(:event)
        end

        it "displays the status" do
          visit events_path
          expect(page).to have_content @event.status.value
        end

        it "has a link to view the event" do
          visit events_path
          expect(page).to have_link("View this event")
        end

        context "with no comments" do

          it "has a comment count of 0" do
            visit events_path
            expect(page).to have_content("0 comments")
          end

        end

        context "with 1 comment" do

          it "has a comment count of 1" do
            @event.problem.comments.create!(:user_id => user.id, :content => "Test content")
            visit events_path
            expect(page).to have_content("1 comment")
          end

        end

      end

      context "with a resolved event" do

        before(:each) do
          @event.create_resolution! FactoryGirl.attributes_for(:resolution)
          visit events_path
        end
        
        it "says so" do
          expect(page).to have_content "Resolved by #{@event.resolved_by.username}"
        end

      end

    end

  end

  describe "GET /events/new" do

    context "as a user" do

      before(:each) do
        login user
        visit new_event_path
      end

      it { expect(page).to have_content "New Event" }

    end

  end

  describe "POST /events" do

    context "as a user" do

      before(:each) do
        login user
        visit new_event_path
      end

      it "creates an event" do
        select @event.status.value, from: "event_status_id"
        fill_in "event_problem_attributes_reported_at_text", with: Time.now.to_s
        fill_in "event_problem_attributes_description", with: "Test description"
        click_button "Create Event"
        expect(page).to have_content "Event was successfully created"
      end

    end

  end

  describe "GET /users/:id" do

    before do
      visit event_path(@event)
    end

    context "as a user" do

      before(:each) do
        login user
      end

      it "displays the event status" do
        expect(page).to have_content @event.status.value
      end

      it "displays a resolution link" do
        expect(page).to have_link "Mark As Resolved"
      end

      it "displays the problem description" do
        expect(page).to have_content @event.problem.description
      end

      it "does not display an edit link" do
        expect(page).to_not have_link "Edit Event"
      end

      it "does not display a destroy link" do
        expect(page).to_not have_link "Delete Event"
      end

      context "with a comment" do

        before(:each) do
          @event.problem.comments.create!(:user_id => user.id, :content => "Test content")
          visit event_path(@event) 
        end

        it "links to the name of the commenter" do
          expect(page).to have_link user.username
        end

        it "displays the comment content" do
          expect(page).to have_content @event.problem.comments.first.content
        end

      end

    end

    context "as an admin" do
      
      before(:each) do
        login admin
      end

      it "displays an edit link" do
        expect(page).to have_link "Edit Event"
      end

      it "displays a destroy link" do
        expect(page).to have_link "Delete Event"
      end

    end

  end

end
