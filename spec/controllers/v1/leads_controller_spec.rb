require 'rails_helper'

RSpec.describe Api::V1::LeadsController do

  before do
    @lead = create(:lead)
    @lead2 = create(:lead)
    @event_1 = create(:event, lead: @lead)
    @event_2 = create(:event, created_at: Date.yesterday, lead: @lead)
    @event_3 = create(:event, created_at: 2.days.ago, lead: @lead)
  end

  describe 'GET index' do
    it "should return all leads" do
      get :index
      expect(assigns(:leads)).to eq([@lead])
    end

    it "should sort lead events in descending order" do
      get :index
      lead = assigns(:leads).find(@lead.id)
      expect(lead.events).to eq([@event_1, @event_2, @event_3])
    end
  end

  describe 'GET show' do
    it "should return one lead based on a lead id" do
      get :show, id: @lead.id
      expect(assigns(:lead)).to eq(@lead)
    end
  end

  describe 'POST create' do
    it "should create a lead" do
      
    end
  end
end