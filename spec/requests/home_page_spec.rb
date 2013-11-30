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

    before(:each) do
      @unresolved_event = FactoryGirl.create(:event)
      visit "/"
    end

    it "should display the unresolved event" do
      expect(page).to have_content @unresolved_event.status.value
      expect(page).to have_content @unresolved_event.problem.description
      expect(page).to have_link "View this event"
    end

    it "should have a link to report another problem" do
      expect(page).to have_link "Report another problem"
    end
  end
end
