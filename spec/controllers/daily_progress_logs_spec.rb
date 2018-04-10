require 'rails_helper'

RSpec.describe DailyProgressLogsController do
  include Devise::Test::ControllerHelpers

  before do
    admin = create(:admin)
    sign_in admin
  end

  describe 'GET index' do
    it "assigns 'active' to @daily_progress_active" do
      get :index
      expect(assigns(:daily_progress_active)).to eq('active')
    end
  end
end
