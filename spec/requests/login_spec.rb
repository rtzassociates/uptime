require 'spec_helper'

describe "sessions#new" do
  it "should load the login page" do
    visit login_path
    page.should have_content "Please Login"
  end
  
  it "should have a remember_me checkbox" do
    visit login_path
    page.should have_content "Remember me"
  end
  
  it "should have a forgotton password link" do
    visit login_path
    page.should have_content "Forgot your password?"
  end
  
  it "should let a user login" do
    user = FactoryGirl.create(:user)
    visit login_path
    fill_in "username", with: user.username
    fill_in "password", with: user.password
    click_button "Log in"
    page.should have_content "Logged in successfully"
  end
  
  it "should not let an invalid user login" do
    visit login_path
    fill_in "username", with: "bad username"
    fill_in "password", with: "bad password"
    click_button "Log in"
    page.should have_content "Invalid login or password"
  end
end
