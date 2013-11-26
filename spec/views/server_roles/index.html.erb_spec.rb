require 'spec_helper'

describe "server_roles/index" do
  before(:each) do
    assign(:server_roles, [
      stub_model(ServerRole),
      stub_model(ServerRole)
    ])
  end

  it "renders a list of server_roles" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
  end
end
