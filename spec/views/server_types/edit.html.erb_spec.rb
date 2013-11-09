require 'spec_helper'

describe "server_types/edit" do
  before(:each) do
    @server_type = assign(:server_type, stub_model(ServerType,
      :value => "MyText"
    ))
  end

  it "renders the edit server_type form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", server_type_path(@server_type), "post" do
      assert_select "textarea#server_type_value[name=?]", "server_type[value]"
    end
  end
end
