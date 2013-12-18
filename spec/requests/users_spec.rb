require 'spec_helper'

describe "users", :focus => true do

  describe "index" do
    
    context "as a user" do
    
      let(:user) { create(:user) }

      before(:each) do
        login user
        visit users_path
      end

      it "loads the page" do
        expect(page).to have_content "User List"
      end

      it "displays the username" do
        expect(page).to have_content user.username
      end

      it "displays the email address" do
        expect(page).to have_content user.email_address
      end

      it "does not display a link to create a new user" do
        expect(page).to_not have_link "Create a new user"
      end

      it "does not display edit and destroy links" do
        within("table") do
          expect(page).to_not have_link "Edit"
          expect(page).to_not have_link "Delete"
        end
      end

      describe "searching" do

        before(:each) do
          @user1 = create(:user, :username => "Jane")
          @user2 = create(:user, :username => "Joel")
          visit users_path
        end

        it "has a search button" do
          expect(page).to have_button "Search"
        end

        it "finds the correct user" do
          fill_in "search", :with => "Jane"
          click_button "Search"
          expect(page).to have_link "Jane"
          expect(page).to_not have_link "Joel"
        end

        it "finds all matching" do
          fill_in "search", :with => "J"
          click_button "Search"
          expect(page).to have_link "Jane"
          expect(page).to have_link "Joel"
        end

      end

    end

    context "as an admin" do

      let(:admin) { create(:admin) }

      before(:each) do
        login admin
        visit users_path
      end

      it "has a link to create a new user" do
        expect(page).to have_link "Create a new user"
      end

      it "has edit and destroy links" do
        within("table") do
          expect(page).to have_link "Edit"
          expect(page).to have_link "Delete"
        end
      end

    end

  end

  describe "show" do

    context "as a user" do

      let(:user) { create(:user) }

      before(:each) do
        login user
      end

      it "dispays the username" do
        visit user_path(user)
        expect(page).to have_content user.username
      end

      it "does not display edit and destroy links" do
        visit user_path(user)
        within("#user") do
          expect(page).to_not have_link "Edit"
          expect(page).to_not have_link "Destroy"
        end
      end

      it "displays the users time zone" do
        visit user_path(user)
        expect(page).to have_content user.time_zone
      end

      context "with subscriptions" do

        it "displays the subscriptions" do
          user.sites << create(:site, :name => "Site 1")
          user.sites << create(:site, :name => "Site 2")
          user.save
          login user
          visit user_path(user)
          save_and_open_page
          expect(page).to have_link "Site 1"
          expect(page).to have_link "Site 2"
        end

      end

    end
  end
end
