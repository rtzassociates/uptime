require 'spec_helper'

describe "server_roles/edit" do
  before(:each) do
    @server_role = assign(:server_role, stub_model(ServerRole))
  end

  it "renders the edit server_role form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", server_role_path(@server_role), "post" do
    end
  end
end
