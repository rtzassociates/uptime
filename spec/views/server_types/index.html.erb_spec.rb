require 'spec_helper'

describe "server_types/index" do
  before(:each) do
    assign(:server_types, [
      stub_model(ServerType,
        :value => "MyText"
      ),
      stub_model(ServerType,
        :value => "MyText"
      )
    ])
  end

  it "renders a list of server_types" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
  end
end
