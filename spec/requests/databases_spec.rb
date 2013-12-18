require "spec_helper"

describe "databases" do

  describe "index" do

    before(:each) do
      @database = create(:database)
    end

    context "as a user" do

      let(:user) { create(:user) }

      before(:each) do 
        login user
        visit databases_path
      end

      it "displays the name" do
        expect(page).to have_content @database.name
      end

      it "displays the sites that use it" do
        @database.sites << create(:site, :name => "Test Site 1")
        @database.sites << create(:site, :name => "Test Site 2")
        @database.save
        visit databases_path
        expect(page).to have_content("Test Site 1")
        expect(page).to have_content("Test Site 2")
      end

    end

    context "as an admin" do

      let(:admin) { create(:admin) }

      context "with 1 database" do

        before(:each) do
          @database = create(:database)
          login admin
          visit databases_path
        end

        it "displays an edit link" do
          expect(page).to have_content "Edit"
        end

        it "displays a destroy link" do
          expect(page).to have_content "Delete"
        end

        it "has a link to create a new database" do
          expect(page).to have_content "Create a new database"
        end

        it "has a page title" do
          expect(page).to have_content "Database List"
        end

      end

    end

  end

  describe "new" do

    context "as a user" do

      let(:user) { create(:user) }

      it "displays not authorized" do
        login user
        visit new_database_path
        expect(page).to have_content "Not authorized"
      end

    end

    context "as an admin" do

      let(:admin) { create(:admin) }

      before(:each) do
        create(:database_server, :name => "Test Database Server")
        login admin
        visit new_database_path
      end

      it "allows access" do
        expect(page).to have_content "New Database"
      end

      it "creates a new database" do
        fill_in "Database Name", :with => "Test Database"
        select "Test Database Server", :from => "Database Server"
        click_button "Create Database"
        expect(page).to have_content "Database was successfully created"
        expect(page).to have_content "Test Database"
        expect(Database.count).to eq 1
      end

      it "validates" do
        click_button "Create Database"
        expect(page).to_not have_content "Database was successfully created"
      end

    end

  end

  describe "edit" do

    before(:each) do
      @database = create(:database)
    end

    context "as a user" do

      let(:user) { create(:user) }

      before(:each) do
        login user
        visit edit_database_path(@database)
      end

      it "denies access" do
        expect(page).to have_content "Not authorized"
      end

    end

    context "as an admin" do

      let(:admin) { create(:admin) }

      before(:each) do
        login admin
        visit edit_database_path(@database)
      end

      it "allows access" do
        expect(page).to have_content "Edit Database"
      end

      it "updates successfully" do
        fill_in "Database Name", :with => "Updated Test Database"
        click_button "Update Database"
        expect(page).to have_content "Database was successfully updated"
        expect(page).to have_content "Updated Test Database"
      end

    end

  end

  describe "show" do

    context "as a user" do

      let(:user) { create(:user) }

      before(:each) do
        @database = create(:database)
        @database.database_server = create(:database_server)
        @database.save
        login user
        visit database_path(@database)
      end

      it "allows access" do
        expect(page).to have_content @database.name
      end

      it "displays the type" do
        expect(page).to have_content "Database"
      end

      it "links to the database server" do
        expect(page).to have_link @database.database_server.name
      end

    end

    context "as an admin" do
    
      let(:admin) { create(:admin) }

      before(:each) do
        @database = create(:database)
        login admin
        visit database_path(@database)
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
