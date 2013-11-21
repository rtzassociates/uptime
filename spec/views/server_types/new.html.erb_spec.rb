require 'spec_helper'

describe "server_types/new" do
  before(:each) do
    assign(:server_type, stub_model(ServerType,
      :value => "MyText"
    ).as_new_record)
  end

  it "renders new server_type form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", server_types_path, "post" do
      assert_select "textarea#server_type_value[name=?]", "server_type[value]"
    end
  end
end
