require 'spec_helper'

describe 'sites', :focus => true do

  let(:user) { FactoryGirl.create(:user) }

  describe 'index' do

    before(:each) do
      login user
      visit sites_path
    end

    it "displays the page title" do
      expect(page).to have_content "Site"
    end

    context "as a user" do

      it "does not display a link to create a new site" do
        expect(page).to have_selector('.admin', visible: false)
      end

      context "with 1 site" do

        before(:each) do
          @site = FactoryGirl.create(:site)
          visit sites_path
        end

        it "lists the site" do
          expect(page).to have_content @site.name
          expect(page).to have_content @site.site_environment
        end

        context "with 1 url" do
        
          it "has a link to the url" do
            @site.urls.create!(FactoryGirl.attributes_for(:url))
            visit sites_path
            expect(page).to have_link(@site.urls.first.name)
          end  

        end

        context "with 2 urls" do

          it "has links for both urls" do
            @site.urls.create!(FactoryGirl.attributes_for(:url))
            @site.urls.create!(FactoryGirl.attributes_for(:url))
            visit sites_path
            @site.urls.each do |url|
              expect(page).to have_link(url.name)
            end
          end

        end

        it "shows the uptime" do
          expect(page).to have_content "#{@site.uptime}%"
        end

        it "displays a button to subscribe to the site" do
          expect(page).to have_button "Subscribe"
        end

        context "when the current user has subscribed to the site" do

          let(:current_user) { FactoryGirl.create(:user) }

          before(:each) do
            @site.users << current_user
            @site.save
            login current_user
            visit sites_path 
          end

          it "displays a button to unsubscribe" do
            expect(page).to have_button "Unsubscribe"
          end

        end

        it "does not display an edit link" do
          expect(page).to have_selector('td.admin', visible: false)
        end

        it "does not display a destroy link" do
          expect(page).to have_selector('td.admin', visible: false)
        end

      end

    end

    context "as an admin" do

      let(:admin) { FactoryGirl.create(:admin) }

      before(:each) do
        login admin
        visit sites_path
      end

      it "displays a link to create a new site" do
        expect(page).to have_selector('.admin', visible: true)
        expect(page).to have_link "Create a new site"
      end


      context "with 1 site" do

        before(:each) do
          @site = FactoryGirl.create(:site)
          visit sites_path
        end

        it "displays an edit link" do
          expect(page).to have_selector('td.admin', visible: true)
          expect(page).to have_content "Edit"
        end

        it "displays a destroy link" do
          expect(page).to have_selector('td.admin', visible: true)
          expect(page).to have_content "Delete"
        end

      end

    end

  end
end
