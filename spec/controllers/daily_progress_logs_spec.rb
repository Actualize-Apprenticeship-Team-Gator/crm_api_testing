require 'rails_helper'

RSpec.describe DailyProgressLogsController do
  include Devise::Test::ControllerHelpers

  before do
    @admin = create(:admin)
    sign_in @admin
  end

  describe 'GET index' do
    it "assigns 'active' to @daily_progress_active" do
      get :index
      expect(assigns(:daily_progress_active)).to eq('active')
    end

    context "when admin is signed in and params[:email] is that admin's email address" do
      it "it should assign the admin's daily progress logs to @logs" do
        logs = [
          create(:daily_progress_log, admin: @admin),
          create(:daily_progress_log, admin: @admin, date: Date.yesterday)
        ]
        get :index, params: {email: @admin.email}
        expect(assigns(:logs)).to eq(logs)
      end
    end

    context "when no admin is signed in" do
      it "it should redirect to the login page" do
        sign_out @admin
        @daily_progress_logs = create(:daily_progress_log, admin: @admin)
        get :index
        expect(response).to redirect_to(new_admin_session_path)
      end
    end
  end
end
