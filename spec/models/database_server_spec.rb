require 'spec_helper'

describe DatabaseServer do
  it { should respond_to(:database_ids) }
  
  describe "DatabaseServer#public_servers" do
    # returns a list of all servers with a public ip address

    describe "at least one server with a public ip address" do
      server = FactoryGirl.create(:generic_server)
    end
  end
end

