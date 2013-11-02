require 'spec_helper'

describe "interfaces/show" do
  before(:each) do
    @interface = assign(:interface, stub_model(Interface))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
  end
end
