require 'rails_helper'

RSpec.describe Api::V1::LeadsController do
  render_views

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
      expect(assigns(:leads)).to eq([@lead, @lead2])
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
    context "when lead already exists" do
      it "should find a lead based on parameters sent" do
        post :create, params: {email: @lead.email}
        expect(assigns(:lead)).to eq(@lead)
      end
      it "creates an event for the existing lead" do
        expect do
          post :create, params: {email: @lead.email, name: 'footer'}
        end.to change {@lead.events.count}.by 1
      end
      it "Does not create an event for any other lead" do
        expect do
          post :create, params: {email: @lead.email, name: 'footer'}
        end.to change {@lead2.events.count}.by 0
      end
      it "renders a json after a lead event is created" do
        post :create, params: {email: @lead.email}
        expect(JSON.parse(response.body)["email"]).to eq("email@email.com")
      end
    end

    # context "when lead does not exist" do
      #If one of params does not match it creates a lead and attaches an event?

    # end
  end
end