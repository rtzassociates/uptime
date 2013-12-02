require 'spec_helper'

describe Event, :focus => true do
  let(:event) { FactoryGirl.build(:event) }

  it { should respond_to :site_ids }
  it { should respond_to :status_id }
  it { should respond_to :reported_by }
  it { should respond_to :resolved_by }

  it { should have_many :event_sites }
  it { should have_many :sites }

  it { should belong_to :status }
  it { should have_one :problem }
  it { should have_one :resolution }

  it { should validate_presence_of :status_id }

  describe "self#reported_at" do

    before(:each) do
      @older_event = FactoryGirl.create(:older_event) 
      @newer_event = FactoryGirl.create(:newer_event) 
      @events = Event.reported_at
    end
    
    it "recently reported events come first" do
      expect(@events.first).to eq @newer_event
      expect(@events.last).to eq @older_event
    end 

    it "older events do not come first" do
      expect(@events.first).to_not eq @older_event
      expect(@events.last).to_not eq @newer_event
    end

  end

  context "with 2 events reported by different users" do

    before(:each) do
      @user_1  = FactoryGirl.create(:user)
      @user_2  = FactoryGirl.create(:user)
      @event_1 = FactoryGirl.create(:event)
      @event_2 = FactoryGirl.create(:event)
    end

    describe "self#reported_by" do

      let(:events) { Event.reported_by @user_1 }

      it "only returns events for a given user" do
        events.each do |event|
          expect(event.problem.user).to eq @user_1
        end
      end

      it "does not return events for other users" do
        events.each do |event|
          expect(event.problem.user).to_not eq @user_2
        end
      end

    end

    describe "self#resolved_by" do

      before(:each) do
        @event_1.create_resolution!(
          FactoryGirl.attributes_for(
            :resolution,
            :user_id => @user_1.id))

        @event_2.create_resolution!(
          FactoryGirl.attributes_for(
            :resolution,
            :user_id => @user_2.id))
      end

      let(:events) { Event.resolved_by @user_1 }

      it "only returns events for a given user" do
        events.each do |event|
          expect(event.resolution.user).to eq @user_1
        end
      end

      it "does not return events for other users" do
        events.each do |event|
          expect(event.resolution.user).to_not eq @user_2
        end
      end

      it "does not include unresolved events" do
        @unresolved_event = FactoryGirl.create(:event)
        expect(events).to_not include @unresolved_event
      end

    end

  end

  context "with 1 resolved and 1 unresolved event" do

    before(:each) do
      @resolved_event = FactoryGirl.create(:event)
      @resolved_event.create_resolution!(
        FactoryGirl.attributes_for(:resolution))
      @unresolved_event = FactoryGirl.create(:event)
    end

    describe "self#resolved" do

      let(:events) { Event.resolved }

      it "includes resolved events" do
        expect(events).to include @resolved_event
      end

      it "does not include unresolved events" do
        expect(events).to_not include @unresolved_event
      end

    end

    describe "self#unresolved" do

      let(:events) { Event.unresolved }

      it "includes unresolved events" do
        expect(events).to include @unresolved_event
      end

      it "does not include resolved events" do
        expect(events).to_not include @resolved_event
      end

    end

    describe "event#resolved?" do

      it "returns true if resolved" do
        expect(@resolved_event.resolved?).to be true
      end

      it "returns false if unresolved" do
        expect(@unresolved_event.resolved?).to be false
      end

    end

    describe "event#unresolved?" do

      it "returns true if unresolved" do
        expect(@unresolved_event.unresolved?).to be true
      end

      it "returns false if resolved" do
        expect(@resolved_event.unresolved?).to be false
      end

    end

  end

  describe "event#email_recipients" do

    before(:each) do
      @reporter = FactoryGirl.create(:user)
      @admin = FactoryGirl.create(:admin)
      @event = FactoryGirl.create(:event,
        :problem_attributes => FactoryGirl.attributes_for(:problem, :user_id => @reporter.id))
    end

    it "includes the reporter in the recipient list" do
      expect(@event.email_recipients).to include @reporter.email_address
    end

    it "includes admins in the recipient list" do
      expect(@event.email_recipients).to include @admin.email_address
    end

    context "with a site and subscribers" do

      before(:each) do
        @site = FactoryGirl.create(:site)
        @subscriber = FactoryGirl.create(:user)
        @site.subscriptions.create!(:user_id => @subscriber.id)
        @event.sites << @site
        @event.save
      end

      it "includes them in the recipient list" do
        expect(@event.email_recipients).to include @subscriber.email_address
      end

      it "does not include non-subscribers" do
        @non_subscriber = FactoryGirl.create(:user)
        expect(@event.email_recipients).to_not include @non_subscriber.email_address
      end

    end

  end

  describe "event#duration" do

    let(:event) { FactoryGirl.create(:event) }

    it "returns the duration (unresolved)" do
      event.problem.reported_at_text = 1.day.ago.to_s
      expect(event.duration).to eq 86400
    end

    it "returns the duration (resolved)" do
      event.problem.update_attributes!(
        :reported_at_text => 2.days.ago.to_s)
      event.create_resolution!(
        FactoryGirl.attributes_for(:resolution,
        :resolved_at_text => 1.day.ago.to_s))
      expect(event.duration).to eq 86400
    end

  end

  describe "event#subscribers" do

    before(:each) do
      @site = FactoryGirl.create(:site)
      @subscriber = FactoryGirl.create(:user)
      @site.subscriptions.create!(:user_id => @subscriber.id)
      @event = FactoryGirl.create(:event)
      @event.sites << @site
      @event.save
    end

    it "returns a list of subscribers" do
      expect(@event.subscribers).to include @subscriber
    end

    it "does not return non-subscribers" do
      @non_subscriber = FactoryGirl.create(:user)
      expect(@event.subscribers).to_not include @non_subscriber
    end

  end
  
end
