require 'spec_helper'

describe "server_locations/new" do
  before(:each) do
    assign(:server_location, stub_model(ServerLocation,
      :name => "MyString",
      :notes => "MyText"
    ).as_new_record)
  end

  it "renders new server_location form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", server_locations_path, "post" do
      assert_select "input#server_location_name[name=?]", "server_location[name]"
      assert_select "textarea#server_location_notes[name=?]", "server_location[notes]"
    end
  end
end
