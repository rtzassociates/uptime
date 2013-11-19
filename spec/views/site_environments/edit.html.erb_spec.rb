require 'spec_helper'

describe "site_environments/edit" do
  before(:each) do
    @site_environment = assign(:site_environment, stub_model(SiteEnvironment,
      :name => "MyString"
    ))
  end

  it "renders the edit site_environment form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", site_environment_path(@site_environment), "post" do
      assert_select "input#site_environment_name[name=?]", "site_environment[name]"
    end
  end
end
