require 'spec_helper'

describe "database_servers/show" do
  before(:each) do
    @database_server = assign(:database_server, stub_model(DatabaseServer,
      :name => "Name",
      :description => "MyText"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Name/)
    rendered.should match(/MyText/)
  end
end
