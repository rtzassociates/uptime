require 'spec_helper'

describe "server_types/show" do
  before(:each) do
    @server_type = assign(:server_type, stub_model(ServerType,
      :value => "MyText"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/MyText/)
  end
end
