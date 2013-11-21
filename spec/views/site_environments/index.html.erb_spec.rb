require 'spec_helper'

describe "site_environments/index" do
  before(:each) do
    assign(:site_environments, [
      stub_model(SiteEnvironment,
        :name => "Name"
      ),
      stub_model(SiteEnvironment,
        :name => "Name"
      )
    ])
  end

  it "renders a list of site_environments" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Name".to_s, :count => 2
  end
end
