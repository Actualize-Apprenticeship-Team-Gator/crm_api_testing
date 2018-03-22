class SettingsController < ApplicationController
  def index
    @settings_active = "active"
    unless Setting.find_by(admin_id: current_admin.id)
      Setting.create(admin_id: current_admin.id)
    end
    @settings = Setting.find_by(admin_id: current_admin.id)
  end

  def update
    @settings = Setting.find_by(admin_id: current_admin.id)
    new_content = params["settings"]["auto_text_content"]
    @settings.auto_text_content = new_content
    if @settings.save
      flash[:success] = "Settings Saved!"
      redirect_to '/'
    else
      redirect_to "/settings/edit"
    end
  end

  def setting_params
    params.require(:setting).permit(:admin_id, :auto_text_content)
  end
end
