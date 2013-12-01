require 'spec_helper'

describe GenericServer do

  let(:server) { FactoryGirl.build(:generic_server) }

  describe "#role_name" do

    context "without a role name" do
 
      before do
        server.server_role_id = nil
      end 

      it "returns a titlecase type name" do
        expect(server.role_name).to eq "Generic Server"
      end
    end

    context "with a role name" do

      it "returns a titlecase custom role name" do
        expect(server.role_name).to eq "Custom Server"
      end

    end

  end

end
