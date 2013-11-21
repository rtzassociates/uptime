require 'spec_helper'

describe "interfaces/new" do
  before(:each) do
    assign(:interface, stub_model(Interface).as_new_record)
  end

  it "renders new interface form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", interfaces_path, "post" do
    end
  end
end
