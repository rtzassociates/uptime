require 'spec_helper'

describe "resolving an event" do

  let(:user) { create(:user) }

  before do
    @event = create(:event)
    login user
  end

  it "resolves an event" do
    visit event_path(@event)
    click_link "Mark As Resolved"
    fill_in "resolution_description", :with => "Test description"
    click_button "Mark as resolved"
    expect(page).to have_content "Resolution successfully created"
    expect(page).to have_content "Resolved by #{@event.resolved_by.username}"
  end

end
