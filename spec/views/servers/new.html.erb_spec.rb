require 'spec_helper'

describe "servers/new" do
  before(:each) do
    assign(:server, stub_model(Server,
      :name => "MyString",
      :description => "MyText"
    ).as_new_record)
  end

  it "renders new server form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", servers_path, "post" do
      assert_select "input#server_name[name=?]", "server[name]"
      assert_select "textarea#server_description[name=?]", "server[description]"
    end
  end
end
