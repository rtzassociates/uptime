require 'spec_helper'

describe "GET /events/:id" do

  describe "commenting on a event" do

    before(:each) do
      @event = FactoryGirl.create(:event)
    end

    context "as a user" do

      let(:user) { FactoryGirl.create(:user) }

      before(:each) do
        login user
        visit event_path(@event)
      end

      it "creates comments" do
        fill_in "comment_content", :with => "Test comment"
        click_button "Submit Comment"
        expect(page).to have_content "Thanks for your comment"
        expect(page).to have_content "Test comment"
        expect(page).to have_content @event.problem.comments.first.user.username
      end

      it "does not create a comment if the content is blank" do
        click_button "Submit Comment"
        expect(page).to have_content "Comment content can't be blank"
      end

      it "lets users edit their own comments" do
        fill_in "comment_content", :with => "Test comment"
        click_button "Submit Comment"
        click_link "Edit"
        expect(page).to have_content "Edit Comment"
        fill_in "comment_content", :with => "Updated test comment"
        click_button "Submit"
        expect(page).to have_content "Comment was successfully updated"
        expect(page).to have_content "Updated test comment"
      end

      it "does not let users edit comments created by other users" do
        other_user = FactoryGirl.create(:user)
        @event.problem.comments.create!(:user_id => other_user.id, :content => "Test comment")
        visit event_path(@event)
        within('#comments') do
          expect(page).to_not have_content "Edit"
        end
      end

    end

    context "as an admin" do

      let(:admin) { FactoryGirl.create(:admin) }

      before(:each) do
        login admin
        visit event_path(@event)
      end

      it "lets admins edit comments created by other users" do
        other_user = FactoryGirl.create(:user)
        @event.problem.comments.create!(:user_id => other_user.id, :content => "Test comment")
        visit event_path(@event)
        within('#comments') do
          expect(page).to have_content "Edit"
        end
      end

    end
  end

end
