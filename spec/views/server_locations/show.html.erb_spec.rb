require 'spec_helper'

describe "server_locations/show" do
  before(:each) do
    @server_location = assign(:server_location, stub_model(ServerLocation,
      :name => "Name",
      :notes => "MyText"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Name/)
    rendered.should match(/MyText/)
  end
end
