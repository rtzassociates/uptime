require 'spec_helper'

describe "Password Resets" do
  describe "performing a password reset" do
    it "should let you reset your password" do
      visit "/"
      click_link "Forgot your password?"
      expect(page).to have_content "Reset My Password"
      fill_in "Email Address", :with => "test@example.com"
      click_button "Reset Password"
      expect(page).to have_content "Email sent with password reset instructions." 
    end
  end
end
