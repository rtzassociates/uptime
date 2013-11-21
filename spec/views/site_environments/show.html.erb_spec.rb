require 'spec_helper'

describe "site_environments/show" do
  before(:each) do
    @site_environment = assign(:site_environment, stub_model(SiteEnvironment,
      :name => "Name"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Name/)
  end
end
