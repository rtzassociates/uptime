require "spec_helper"

describe "database servers" do

  describe "index" do

    before(:each) do
      @database_server = FactoryGirl.create(:database_server)
    end

    context "as a user" do

      let(:user) { FactoryGirl.create(:user) }

      before(:each) do 
        login user
        visit database_servers_path
      end

      it "displays the name" do
        expect(page).to have_content @database_server.name
      end

      context "with databases" do

        before(:each) do

          @database_1 = FactoryGirl.create(:database, :name => "Database 1")
          @database_2 = FactoryGirl.create(:database, :name => "Database 2")

          @database_server.databases << @database_1
          @database_server.databases << @database_2
          @database_server.save

          visit database_servers_path
        end

        it "links to databases" do
          expect(page).to have_link "Database 1"
          expect(page).to have_link "Database 2"
        end

      end

    end

    context "as an admin" do

      let(:admin) { FactoryGirl.create(:admin) }

      context "with 1 database server" do

        before(:each) do
          @database_server = FactoryGirl.create(:database_server)
          login admin
          visit database_servers_path
        end

        it "displays an edit link" do
          expect(page).to have_content "Edit"
        end

        it "displays a destroy link" do
          expect(page).to have_content "Delete"
        end

        it "has a link to create a new database server" do
          expect(page).to have_content "Create a new database server"
        end

        it "has a page title" do
          expect(page).to have_content "Database Server List"
        end

      end

    end

  end

  describe "new" do

    context "as a user" do

      let(:user) { FactoryGirl.create(:user) }

      it "displays not authorized" do
        login user
        visit new_database_server_path
        expect(page).to have_content "Not authorized"
      end

    end

    context "as an admin" do

      let(:admin) { FactoryGirl.create(:admin) }

      before(:each) do
        FactoryGirl.create(:server_type, :value => "Physical")
        FactoryGirl.create(:server_location, :name => "Oakland")
        login admin
        visit new_database_server_path
      end

      it "allows access" do
        expect(page).to have_content "New Database Server"
      end

      it "creates a new database server" do
        fill_in "Server Name", :with => "Test Database Server"
        fill_in "Deployed at", :with => Time.now.to_s
        select "Physical", :from => "Server Type" 
        select "Oakland", :from => "Server Location"
        fill_in "Description", :with => "Test description"
        fill_in "Public IP Address", :with => "127.0.0.1"
        click_button "Create Database server"
        expect(page).to have_content "Database server was successfully created"
        expect(page).to have_content "Test Database Server"
        expect(DatabaseServer.count).to eq 1
      end

      it "validates" do
        click_button "Create Database server"
        expect(page).to_not have_content "Database server was successfully created"
      end

    end

  end

  describe "edit" do

    before(:each) do
      @database_server = FactoryGirl.create(:database_server)
    end

    context "as a user" do

      let(:user) { FactoryGirl.create(:user) }

      before(:each) do
        login user
        visit edit_database_server_path(@database_server)
      end

      it "denies access" do
        expect(page).to have_content "Not authorized"
      end

    end

    context "as an admin" do

      let(:admin) { FactoryGirl.create(:admin) }

      before(:each) do
        login admin
        visit edit_database_server_path(@database_server)
      end

      it "allows access" do
        expect(page).to have_content "Edit Database Server"
      end

      it "updates successfully" do
        fill_in "Server Name", :with => "Updated Test Database Server"
        click_button "Update Database server"
        expect(page).to have_content "Database server was successfully updated"
        expect(page).to have_content "Updated Test Database Server"
      end

    end

  end

  describe "show" do

    context "as a user" do

      let(:user) { FactoryGirl.create(:user) }

      before(:each) do
        @database_server = FactoryGirl.create(:database_server)
        @database_server.server_type = FactoryGirl.create(:server_type, :value => "Physical")
        @database_server.server_location = FactoryGirl.create(:server_location, :name => "Oakland")
        @database_server.save
        login user
        visit database_server_path(@database_server)
      end

      it "allows access" do
        expect(page).to have_content @database_server.name
      end

      it "displays the type" do
        expect(page).to have_content "Database Server"
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
          @database_server.ip_addresses << @ip_address
          @database_server.save
          visit database_server_path(@database_server)
        end

        it "displays the network name" do
          expect(page).to have_content "Test Network"
        end

        it "displays the ip address" do
          expect(page).to have_content "192.168.1.1"
        end

      end

      context "with a database" do

        it "displays the database" do
          database = FactoryGirl.create(:database)
          database_server = database.database_server
          visit database_server_path(database_server)
          expect(page).to have_content database.name
        end

      end

    end

    context "as an admin" do
    
      let(:admin) { FactoryGirl.create(:admin) }

      before(:each) do
        @database_server = FactoryGirl.create(:database_server)
        login admin
        visit database_server_path(@database_server)
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
