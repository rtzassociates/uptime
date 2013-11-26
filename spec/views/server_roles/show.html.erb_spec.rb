require 'spec_helper'

describe "server_roles/show" do
  before(:each) do
    @server_role = assign(:server_role, stub_model(ServerRole))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
  end
end
