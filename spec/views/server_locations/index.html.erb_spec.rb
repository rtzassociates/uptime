require 'spec_helper'

describe "server_locations/index" do
  before(:each) do
    assign(:server_locations, [
      stub_model(ServerLocation,
        :name => "Name",
        :notes => "MyText"
      ),
      stub_model(ServerLocation,
        :name => "Name",
        :notes => "MyText"
      )
    ])
  end

  it "renders a list of server_locations" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
  end
end
