require 'spec_helper'

describe "pages#home" do
  
  let(:user) { FactoryGirl.create(:user) }
  
  it "should redirect to a login page if no user is logged in" do
    visit root_path
    page.should have_content "Please Login"
  end
  
  it "should say there are no problems reported when there are no problems reported" do
    login user
    visit root_path
    page.should have_content "Currently, there are no problems reported"
  end
  
  it "should have a link to report a problem" do
    login user
    visit root_path
    page.should have_link "Report a problem"
  end
  
  it "should have a link to report another problem if a problem has already been reported" do
    event = FactoryGirl.create(:event)
    login user
    visit root_path
    page.should have_link "Report another problem"
  end
  
  it "should not say there are no problems reported when there are problems reported" do
    event = FactoryGirl.create(:event)
    login user
    visit root_path
    page.should_not have_content "Currently, there are no problems reported"
  end
  
  it "should display the event status of the unresolved problem" do
    event  = FactoryGirl.create(:event)
    status = FactoryGirl.create(:status)
    login user
    visit root_path
    page.should have_content status.value
  end
  
end
