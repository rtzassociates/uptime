require 'spec_helper'

describe GenericServer do
  describe "Server#role_name" do
    describe "without a role name" do
 
      before do
        @server = FactoryGirl.build(:generic_server)
        @server.server_role_id = nil
      end 

      it "returns a titlecase type name" do
        expect(@server.role_name).to eq "Generic Server"
      end
    end

    describe "with a role name" do

      before { @server = FactoryGirl.build(:generic_server) }
      
      it "returns a titlecase custom role name" do
        expect(@server.role_name).to eq "Custom Server"
      end
    end
  end
end
