require 'rails_helper'
# require_relative "../fake_sms"

RSpec.describe Lead, type: :model do
  before :each do 
    @lead = create(:lead)
  end

  describe "Factory" do 
    it "should prove the factory works" do 
      expect(build :lead).to be_valid
    end 
  end 

  describe "#full_name" do 
    context "when the lead has a first and last name" do
      it "should return the leads full name" do 
        expect(@lead.full_name).to eq @lead.first_name + " " + @lead.last_name
      end
    end
  end 

  describe "#processed_within_minutes" do 
    context "when the lead has been processed" do 
      it "should return processed in minutes" do 
        @lead.process_time = Time.new(2018, 04, 16, 12, 0, 0, "+09:00")
        @lead.created_at = Time.new(2018, 04, 16, 11, 30, 0, "+09:00")
        expect(@lead.processed_within_minutes).to eq "30 minutes"
      end
    end

    context "when the lead has not been processed" do 
      it "should return not called" do 
        @lead.update_column(:process_time, nil)
        expect(@lead.processed_within_minutes).to eq "not called"
      end
    end
  end

  describe "#has_outreaches" do 
    context "when a lead does not have an outreach" do 
      it "should return false" do 
        expect(@lead.has_outreaches).to eq false
      end
    end

    context "when a lead has an outreach" do 
      before :each do  
        @outreach = create(:outreach, lead: @lead)
      end
      it "should return true" do
        expect(@lead.has_outreaches).to eq true
      end
    end
  end

  describe "#has_events" do 
    context "when a lead does not have an event" do 
      it "should return false" do 
        expect(@lead.has_events).to eq false
      end
    end

    context "when a lead has an event" do 
      before :each do 
        @event = create(:event, lead: @lead)
      end
      it "should return true" do 
        expect(@lead.has_events).to eq true 
      end
    end
  end

  describe "#event_since_last_outreach" do
    before :each do 
      @event = create(:event, lead: @lead)  
      @outreach = create(:outreach, lead: @lead)
    end

    context "when a lead has not had an event after last outreach" do   
      it "should return false" do 
        @event.update(created_at: Date.yesterday) 
        !expect(@lead.event_since_last_outreach)
      end
    end

    context "when a lead has had an event after last outreach" do      
      it "should return true" do 
        @outreach.update(created_at: Date.yesterday)
        expect(@lead.event_since_last_outreach)
      end
    end
  end

  describe "#reset" do 
    before :each do 
      @lead = create(:lead, hot: false, contacted: true, connected: true, exclude_from_calling: true, appointment_date: Time.now, advisor: "hi", number_of_dials: 4)
      @lead.reset
      # @lead.reload  
    end 

    it "should return true for hot" do 
      expect(@lead.hot).to be true
    end

    it "should return false for contacted" do 
      expect(@lead.contacted).to be false
    end
    
    it "should return false for connected" do 
      expect(@lead.connected).to be false
    end
    
    it "should return false for exclude_from_calling" do 
      expect(@lead.exclude_from_calling).to be false
    end
    
    it "should return nil for appointment_date" do 
      expect(@lead.appointment_date).to be_nil
    end
    
    it "should return nil for advisor" do 
      expect(@lead.advisor).to be_nil
    end
    
    it "should return 0 for number_of_dials" do 
      expect(@lead.number_of_dials).to eq 0
    end
  end

  describe "#self.next" do 
    context "when there are multiple valid leads" do 
      it "should return the newest valid lead" do 
        lead = create(:lead, :next_lead)
        next_lead = create(:lead, :next_lead)
        create(:event, name: "Started Application", lead: next_lead)
        create(:event, 
          name: "Started Application", 
          updated_at: Date.yesterday, 
          lead: lead
        )
        expect(Lead.next).to eq next_lead
      end
    end

    context "when there are no valid leads" do 
      it "should return nil" do 
        create(:event)
        expect(Lead.next).to be_nil
      end
    end
  end

  describe "#text" do 
    it "should pass the correct arguements to messages.create" do 
      allow_any_instance_of(Twilio::REST::Messages).to receive(:create).with({
        from: ENV['TWILIO_PHONE_NUMBER'], 
        to: @lead.phone, 
        body: "Hi #{@lead.first_name}! This is Rena from Actualize. Do you have a minute to chat?"})
      @lead.text
    end
  end
end
