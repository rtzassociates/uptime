require 'spec_helper'

describe "databases/index" do
  before(:each) do
    assign(:databases, [
      stub_model(Database,
        :name => "Name",
        :server_id => 1
      ),
      stub_model(Database,
        :name => "Name",
        :server_id => 1
      )
    ])
  end

  it "renders a list of databases" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
  end
end
