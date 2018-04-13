class DailyProgressLogsController < ApplicationController
  before_action :authenticate_admin!
  def index
    @daily_progress_active = "active"
    @logs = current_admin.daily_progress_logs.order(date: :desc)
  end
end