require 'spec_helper'

describe "site_environments/new" do
  before(:each) do
    assign(:site_environment, stub_model(SiteEnvironment,
      :name => "MyString"
    ).as_new_record)
  end

  it "renders new site_environment form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", site_environments_path, "post" do
      assert_select "input#site_environment_name[name=?]", "site_environment[name]"
    end
  end
end
