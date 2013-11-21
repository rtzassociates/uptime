require 'spec_helper'

describe "interfaces/edit" do
  before(:each) do
    @interface = assign(:interface, stub_model(Interface))
  end

  it "renders the edit interface form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", interface_path(@interface), "post" do
    end
  end
end
