describe "/" do
  
  let(:user) { FactoryGirl.create(:user) }

  before(:each) do
    login user
  end

  describe "when no events have been reported" do

    before(:each) do
      visit "/"
    end

    it "should say so" do
      expect(page).to have_content "Currently, there are no problems reported"
    end

    it "should have a link to create an event" do
      expect(page).to have_link "Report a problem"
    end

  end

  describe "with one event reported (but not resolved)" do

    it "should display the unresolved event" do
      unresolved_event = FactoryGirl.create(:event)
      visit "/"
      expect(page).to have_content unresolved_event.problem.description
    end
  end
end
