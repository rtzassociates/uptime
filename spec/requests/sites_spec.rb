require 'spec_helper'

describe 'sites' do

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

        it "does not display an edit link" do
          expect(page).to have_selector('td.admin', visible: false)
        end

        it "does not display a destroy link" do
          expect(page).to have_selector('td.admin', visible: false)
        end

        it "displays a button to subscribe to the site" do
          expect(page).to have_button "Subscribe"
        end

        describe "subscribing" do
          
          it "creates and destroys a subscription" do
            click_button "Subscribe"
            expect(user.sites.count).to eq 1
            click_button "Unsubscribe"
            expect(user.sites.count).to eq 0
          end

        end

      end

    end

    context "with multiple sites" do

      before(:each) do
        @site_1 = FactoryGirl.create(:site, :name => "Site 1")
        @site_2 = FactoryGirl.create(:site, :name => "Site 2")
        @site_3 = FactoryGirl.create(:site, :name => "Site 3")
        visit sites_path
      end

      describe "when searching" do

        context "with 1 match" do

          it "the match is the only site included in results" do
            fill_in "search", :with => "Site 1"
            click_button "Search"
            expect(page).to have_content "Site 1"
            expect(page).to_not have_content "Site 2"
            expect(page).to_not have_content "Site 2"
          end

        end

        context "with 3 matches" do

          it "all the matching sites are returned" do
            fill_in "search", :with => "Site"
            click_button "Search"
            expect(page).to have_content "Site 1"
            expect(page).to have_content "Site 2"
            expect(page).to have_content "Site 3"
          end

        end

        context "with no matches" do

          it "no sites are returned" do
            fill_in "search", :with => "NO MATCH"
            click_button "Search"
            expect(page).to_not have_content "Site 1"
            expect(page).to_not have_content "Site 2"
            expect(page).to_not have_content "Site 3"
          end

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

  describe "new" do

    context "as a user" do

      let(:user) { FactoryGirl.create(:user) }

      it "user is not authorized" do
        login user
        visit new_site_path
        expect(page).to have_content "Not authorized"
      end

    end

    context "as an admin" do

      let(:admin) { FactoryGirl.create(:admin) }

      before(:each) do
        @site_environment = FactoryGirl.create(:site_environment)
        @url = FactoryGirl.create(:url)
        @application_server = FactoryGirl.create(:application_server)
        @database = FactoryGirl.create(:database)
        @subscriber = FactoryGirl.create(:user)
        login admin
        visit new_site_path
      end

      it "displays the page title" do
        expect(page).to have_content "New Site"
      end

      it "creates a site" do
        fill_in "Site Name", :with => "Test Site"
        select @site_environment.name, from: "site_site_environment_id"
        fill_in "Site Description", :with => "Test description"
        select @application_server.name, from: "site_application_server_ids"
        select @database.name, from: "site_database_ids"
        select @subscriber.username, from: "site_user_ids"
        click_button "Create Site"
        expect(page).to have_content "Site successfully created"
        expect(Site.count).to be 1
      end

    end

  end

  describe "show" do

    before(:each) do
      @site = FactoryGirl.create(:site)
    end

    context "as a user" do

      let(:user) { FactoryGirl.create(:user) }

      before(:each) do
        login user
        visit site_path(@site)
      end

      it "displays the site name" do
        expect(page).to have_content @site.name
      end

        it "does not display an edit link" do
          within("#site") do
            expect(page).to_not have_link "Edit"
          end
        end

        it "does not display a destroy link" do
          within("#site") do
            expect(page).to_not have_link "Delete"
          end
        end

      context "with 1 url" do
      
        before(:each) do
          @url = FactoryGirl.create(:url)
          @site.urls << @url
          @site.save
          visit site_path(@site)
        end

        it "displays the url" do
          expect(page).to have_content @url.name
        end

      end

      context "with 1 application server" do
        
        before(:each) do
          @application_server = FactoryGirl.create(:application_server)
          @site.application_servers << @application_server
          @site.save
          visit site_path(@site)
        end

        it "displays the application server" do
          expect(page).to have_content @application_server.name
        end

      end

      context "with 1 database" do

        before(:each) do
          @database = FactoryGirl.create(:database)
          @site.databases << @database
          @site.save
          visit site_path(@site)
        end

        it "displays the database" do
          expect(page).to have_content @database.name
        end

      end

      context "with 1 subscriber" do

        before(:each) do
          @subscriber = FactoryGirl.create(:user)
          @site.users << @subscriber
          @site.save
          visit site_path(@site)
        end

        it "displays the subscriber" do
          expect(page).to have_content @subscriber.username
        end

      end

      context "with associated events" do

        before(:each) do

          @event_1 = FactoryGirl.create(:event, 
            :problem_attributes => FactoryGirl.attributes_for(:problem, 
            :description => "Test Event 1"))

          @event_2 = FactoryGirl.create(:event, 
            :problem_attributes => FactoryGirl.attributes_for(:problem, 
            :description => "Test Event 2"))

          @event_3 = FactoryGirl.create(:event, 
            :problem_attributes => FactoryGirl.attributes_for(:problem, 
            :description => "Test Event 3"))

          @site.events << @event_1
          @site.events << @event_2
          @site.events << @event_3
          @site.save 
          visit site_path(@site)
        end

        it "lists the associates events" do
          expect(page).to have_content @event_1.problem.description
          expect(page).to have_content @event_2.problem.description
          expect(page).to have_content @event_3.problem.description
        end

      end

    end

    context "as an admin" do

      let(:admin) { FactoryGirl.create(:admin) }

      before(:each) do
        @event = FactoryGirl.create(:event)
        login admin
        visit event_path(@event)
      end

      it "displays an edit link" do
        expect(page).to have_link "Edit"
      end

      it "displays a destroy link" do
        expect(page).to have_link "Delete"
      end

    end

  end

end
