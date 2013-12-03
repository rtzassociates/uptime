require 'spec_helper'

describe "servers" do

  describe "index" do

    context "as a user" do

      let(:user) { FactoryGirl.create(:user) }

      before(:each) do
        login user
      end


      context "as a generic server" do

        it "displays the name" do
          server = FactoryGirl.create(:generic_server)
          visit servers_path
          expect(page).to have_content server.name
        end

        it "displays the public ip address" do
          server = FactoryGirl.create(:generic_server)
          expect(page).to have_content server.public_ip_address
        end

        context "with a custom role" do

          it "displays the custom role" do
            server = FactoryGirl.create(:generic_server, :server_role_id => FactoryGirl.create(:server_role).id)
            visit servers_path
            expect(page).to have_content server.server_role.role.titlecase
          end

        end

        context "without a custom role" do

          it "displays the type" do
            FactoryGirl.create(:generic_server, :server_role_id => nil) 
            visit servers_path
            expect(page).to have_content "Generic Server"
          end

        end

      end

      context "as an application server" do

        it "displays the type" do
          FactoryGirl.create(:application_server)
          visit servers_path
          expect(page).to have_content "Application Server"
        end

      end

      context "as a database server" do

        it "displays the type" do
          FactoryGirl.create(:database_server)
          visit servers_path
          expect(page).to have_content "Database Server"
        end

      end


      context "with 1 network" do

        it "displays the network name" do
          FactoryGirl.create(:network, :name => "Test Network")
          visit servers_path
          expect(page).to have_content "Test Network"
        end

      end

      context "with 2 networks" do

        it "displays both network names" do
          FactoryGirl.create(:network, :name => "Test Network 1")
          FactoryGirl.create(:network, :name => "Test Network 2")
          visit servers_path
          expect(page).to have_content "Test Network 1"
          expect(page).to have_content "Test Network 2"
        end

      end

      it "has an edit link" do
        FactoryGirl.create(:generic_server)
        visit servers_path
        expect(page).to have_content "Edit"
      end

      it "has a destroy link" do
        FactoryGirl.create(:generic_server)
        visit servers_path
        expect(page).to have_content "Delete"
      end
      
      it "links are hidden" do
        FactoryGirl.create(:generic_server)
        visit servers_path
        expect(page).to have_selector('.admin', visible: false)
      end

    end

    context "as an admin" do

      let(:admin) { FactoryGirl.create(:admin) }

      before(:each) do
        login admin
      end

      it "links are not hidden" do
        FactoryGirl.create(:generic_server)
        visit servers_path
        expect(page).to have_selector('.admin', visible: true)
      end

      describe "following the edit link" do

        context "as an application server" do

          it "takes you to the application server edit page" do
            FactoryGirl.create(:application_server)
            visit servers_path
            click_link "Edit"
            expect(page).to have_content "Edit Application Server"
          end

        end

        context "as a database server" do

          it "takes you to the database server edit page" do
            FactoryGirl.create(:database_server)
            visit servers_path
            click_link "Edit"
            expect(page).to have_content "Edit Database Server" 
          end

        end

        context "as a generic server" do

          it "takes you to the generic server edit page" do
            FactoryGirl.create(:generic_server)
            visit servers_path
            click_link "Edit"
            expect(page).to have_content "Edit Generic Server"
          end

        end

      end

    end

  end

end
