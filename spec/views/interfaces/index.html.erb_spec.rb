require 'spec_helper'

describe "interfaces/index" do
  before(:each) do
    assign(:interfaces, [
      stub_model(Interface),
      stub_model(Interface)
    ])
  end

  it "renders a list of interfaces" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
  end
end
