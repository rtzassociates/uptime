require 'spec_helper'

describe Server do

  it { should respond_to(:name) }
  it { should respond_to(:deployed_at_text) }
  it { should respond_to(:description) }
  it { should respond_to(:name) }
  it { should respond_to(:ip_addresses) }
  it { should respond_to(:server_type_id) }
  it { should respond_to(:server_location_id) }
  it { should respond_to(:server_role_id) }
  it { should respond_to(:public_ip_address) }

  it { should belong_to(:server_role) }
  it { should belong_to(:server_type) }
  it { should belong_to(:server_location) }

  it { should validate_presence_of(:name) }
  it { should validate_uniqueness_of(:name) }
  it { should validate_presence_of(:deployed_at) }

  let(:server) { FactoryGirl.build(:generic_server) }

  describe "Server#edit_route_path" do

    it "should provide an edit route" do
      expect(server.edit_route_path).to eq "edit_generic_server_path"
    end

  end

  describe "Server#deployed_at_text" do

    describe "with valid deployed at text" do

      it "should be valid" do
        server.deployed_at_text = "Jan 1, 1970 at 12:01 AM"
        expect(server).to be_valid
      end

    end

    describe "with invalid deployed at text" do

      it "should not be valid" do
        server.deployed_at_text = "Some invalid date"
        expect(server).to_not be_valid
      end

    end

  end

  describe "#public_ip_address" do

    describe "with valid ip address" do

      it "should be valid" do
        server.public_ip_address = "127.0.0.1"
        expect(server).to be_valid
      end

    end

    describe "with an invalid ip address" do

      it "should not be valid" do
        server.public_ip_address = "192.168.1.256"
        expect(server).to_not be_valid
      end

    end

    describe "with a nil public ip address" do

      it "should be valid" do
        server.public_ip_address = nil
        expect(server).to be_valid
      end

    end

  end

end
