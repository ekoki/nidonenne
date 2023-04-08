class NotificationSettingsController < ApplicationController
  def new
    @notification_settings = NotificationSetting.new
  end

  def create
    @notification_setting =  NotificationSetting.new(user_params)
    if notification_setting.save
      redirect_to dashboards_path, notice: t('.success')
    else
      flash.now[:alert] = t('.fail')
      render :new
    end
  end


  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

end
