require 'spec_helper'

describe "server_roles/new" do
  before(:each) do
    assign(:server_role, stub_model(ServerRole).as_new_record)
  end

  it "renders new server_role form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", server_roles_path, "post" do
    end
  end
end
