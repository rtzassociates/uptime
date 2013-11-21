require 'spec_helper'

describe "databases/new" do
  before(:each) do
    assign(:database, stub_model(Database,
      :name => "MyString",
      :server_id => 1
    ).as_new_record)
  end

  it "renders new database form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", databases_path, "post" do
      assert_select "input#database_name[name=?]", "database[name]"
      assert_select "input#database_server_id[name=?]", "database[server_id]"
    end
  end
end
