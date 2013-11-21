require 'spec_helper'

describe "pages#home" do
  
  it "should say there are no problems reported when there are no problems reported" do
    visit root_path
    page.should have_content "Currently, there are no problems reported"
  end
  
end