require 'rails_helper'

RSpec.describe Lead, type: :model do
  before :all do 
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
        @lead.process_time
        expect(@lead.processed_within_minutes).to eq "0 minutes"
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
      before :all do  
        @outreach = create(:outreach, lead: @lead)
      end
      it "should return true" do
        expect(@lead.has_outreaches).to eq true
      end
    end
  end
end
