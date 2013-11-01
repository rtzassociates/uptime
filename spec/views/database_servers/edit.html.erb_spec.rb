require 'spec_helper'

describe "database_servers/edit" do
  before(:each) do
    @database_server = assign(:database_server, stub_model(DatabaseServer,
      :name => "MyString",
      :description => "MyText"
    ))
  end

  it "renders the edit database_server form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", database_server_path(@database_server), "post" do
      assert_select "input#database_server_name[name=?]", "database_server[name]"
      assert_select "textarea#database_server_description[name=?]", "database_server[description]"
    end
  end
end
