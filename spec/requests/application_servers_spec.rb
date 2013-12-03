require "spec_helper"

describe "application servers" do

  describe "index" do

    before(:each) do
      @application_server = FactoryGirl.create(:application_server)
    end

    context "as a user" do

      let(:user) { FactoryGirl.create(:user) }

      before(:each) do 
        login user
        visit application_servers_path
      end

      it "displays the name" do
        expect(page).to have_content @application_server.name
      end

      context "with sites" do

        before(:each) do
          @site_1 = FactoryGirl.create(:site, :name => "Site 1")
          @site_2 = FactoryGirl.create(:site, :name => "Site 2")
          @application_server.sites << @site_1
          @application_server.sites << @site_2
          @application_server.save
          visit application_servers_path
        end

        it "links to the associated sites" do
          expect(page).to have_link "Site 1"
          expect(page).to have_link "Site 2"
        end

      end

      context "with site urls" do

        before(:each) do
          @site = FactoryGirl.create(:site, :name => "Site 1")
          @site.urls << FactoryGirl.create(:url, :name => "http://www1.example.com")
          @site.urls << FactoryGirl.create(:url, :name => "http://www2.example.com")
          @application_server.sites << @site
          @application_server.save
          visit application_servers_path
        end

        it "links to the site urls" do
          expect(page).to have_link "http://www1.example.com"
          expect(page).to have_link "http://www2.example.com"
        end

      end

      context "with site databases" do

        before(:each) do

          @database_1 = FactoryGirl.create(:database, :name => "Database 1")
          @database_2 = FactoryGirl.create(:database, :name => "Database 2")

          @site = FactoryGirl.create(:site, :name => "Site 1")

          @site.databases << @database_1
          @site.databases << @database_2
          @site.save

          @application_server.sites << @site
          @application_server.save

          visit application_servers_path
        end

        it "links to the site databases" do
          expect(page).to have_link "Database 1"
          expect(page).to have_link "Database 2"
        end

      end

    end

    context "as an admin" do

      let(:admin) { FactoryGirl.create(:admin) }

      context "with 1 application server" do

        before(:each) do
          @application_server = FactoryGirl.create(:application_server)
          login admin
          visit application_servers_path
        end

        it "displays an edit link" do
          expect(page).to have_content "Edit"
        end

        it "displays a destroy link" do
          expect(page).to have_content "Delete"
        end

        it "has a link to create a new application server" do
          expect(page).to have_content "Create a new application server"
        end

        it "has a page title" do
          expect(page).to have_content "Application Server List"
        end

      end

    end

  end

  describe "new" do

    context "as a user" do

      let(:user) { FactoryGirl.create(:user) }

      it "displays not authorized" do
        login user
        visit new_application_server_path
        expect(page).to have_content "Not authorized"
      end

    end

    context "as an admin" do

      let(:admin) { FactoryGirl.create(:admin) }

      before(:each) do
        FactoryGirl.create(:server_type, :value => "Physical")
        FactoryGirl.create(:server_location, :name => "Oakland")
        FactoryGirl.create(:site, :name => "Test Site")
        login admin
        visit new_application_server_path
      end

      it "allows access" do
        expect(page).to have_content "New Application Server"
      end

      it "creates a new application server" do
        fill_in "Server Name", :with => "Test Application Server"
        fill_in "Deployed at", :with => Time.now.to_s
        select "Physical", :from => "Server Type" 
        select "Oakland", :from => "Server Location"
        fill_in "Description", :with => "Test description"
        fill_in "Public IP Address", :with => "127.0.0.1"
        select "Test Site", :from => "application_server_site_ids"
        click_button "Create Application server"
        expect(page).to have_content "Application server was successfully created"
        expect(page).to have_content "Test Application Server"
        expect(ApplicationServer.count).to eq 1
      end

      it "validates" do
        click_button "Create Application server"
        expect(page).to_not have_content "Application server was successfully created"
      end

    end

  end

  describe "edit" do

    before(:each) do
      @application_server = FactoryGirl.create(:application_server)
    end

    context "as a user" do

      let(:user) { FactoryGirl.create(:user) }

      before(:each) do
        login user
        visit edit_application_server_path(@application_server)
      end

      it "denies access" do
        expect(page).to have_content "Not authorized"
      end

    end

    context "as an admin" do

      let(:admin) { FactoryGirl.create(:admin) }

      before(:each) do
        login admin
        visit edit_application_server_path(@application_server)
      end

      it "allows access" do
        expect(page).to have_content "Edit Application Server"
      end

      it "updates successfully" do
        fill_in "Server Name", :with => "Updated Test Application Server"
        click_button "Update Application server"
        expect(page).to have_content "Application server was successfully updated"
        expect(page).to have_content "Updated Test Application Server"
      end

    end

  end

  describe "show" do

    context "as a user" do

      let(:user) { FactoryGirl.create(:user) }

      before(:each) do
        @application_server = FactoryGirl.create(:application_server)
        @application_server.server_type = FactoryGirl.create(:server_type, :value => "Physical")
        @application_server.server_location = FactoryGirl.create(:server_location, :name => "Oakland")
        @application_server.save
        login user
        visit application_server_path(@application_server)
      end

      it "allows access" do
        expect(page).to have_content @application_server.name
      end

      it "displays the type" do
        expect(page).to have_content "Application Server"
      end

      it "displays the server type" do
        expect(page).to have_content "Physical"
      end

      it "displays the server location" do
        expect(page).to have_content "Oakland"
      end

      context "with a network and an ip addresses" do 

        before(:each) do
          @network = FactoryGirl.create(:network, :name => "Test Network")
          @ip_address = FactoryGirl.create(:ip_address, 
            :network_id => @network.id, :value => "192.168.1.1")
          @application_server.ip_addresses << @ip_address
          @application_server.save
          visit application_server_path(@application_server)
        end

        it "displays the network name" do
          expect(page).to have_content "Test Network"
        end

        it "displays the ip address" do
          expect(page).to have_content "192.168.1.1"
        end

      end

      context "with a site" do

        before(:each) do
          @site = FactoryGirl.create(:site)
          @application_server.sites << @site
          @application_server.save
          visit application_server_path(@application_server)
        end

        it "displays the site" do
          expect(page).to have_content @site.name
        end

      end

      context "with site urls" do

        before(:each) do
          @url = FactoryGirl.create(:url)
          @site = FactoryGirl.create(:site)
          @site.urls << @url
          @site.save
          @application_server.sites << @site
          @application_server.save
          visit application_server_path(@application_server)
        end

        it "displays the url" do
          expect(page).to have_content @url.name
        end

      end

    end

    context "as an admin" do
    
      let(:admin) { FactoryGirl.create(:admin) }

      before(:each) do
        @application_server = FactoryGirl.create(:application_server)
        login admin
        visit application_server_path(@application_server)
      end

      it "displays the edit link" do
        expect(page).to have_link "Edit"
      end

      it "displays the destroy link" do
        expect(page).to have_link "Delete"
      end

    end

  end

end
