require 'spec_helper'

describe DatabaseServer do
  it { should respond_to(:database_ids) }
  
  describe "DatabaseServer#public_servers" do
    # returns a list of all servers with a public ip address

    describe "at least one server with a public ip address"
      server = FactoryGirl.server(:server)
      server.ip_addresses.build(:network_id => Network.where("networks.name" => "public").first.id, :value => "8.8.8.8")
      server.save
      public_servers = DatabaseServer.public_servers
      public_servers.each do |server|
      expect(server.public).to be_false
    end
  end
end

