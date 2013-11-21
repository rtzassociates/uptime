require 'spec_helper'

describe "sessions#new" do
  let(:user) { FactoryGirl.create(:user) }
  
  before do
    visit login_path
  end
  
  it "should load the login page" do
    page.should have_content "Please Login"
  end
  
  it "should have a remember_me checkbox" do
    page.should have_content "Remember me"
  end
  
  it "should have a forgotton password link" do
    page.should have_content "Forgot your password?"
  end
  
  it "should let a user login" do
    fill_in "username", with: user.username
    fill_in "password", with: user.password
    click_button "Log in"
    page.should have_content "Logged in successfully"
  end
  
  it "should not let an invalid user login" do
    fill_in "username", with: "bad username"
    fill_in "password", with: "bad password"
    click_button "Log in"
    page.should have_content "Invalid login or password"
  end
end

describe "sessions#destroy" do
  let(:user) { FactoryGirl.create(:user) }
  
  it "should log out the user" do
    login user
    visit root_path
    click_link "Sign out"
    visit root_path
    page.should have_content "Please Login"
  end
end
