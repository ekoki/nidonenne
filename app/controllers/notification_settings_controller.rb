class NotificationSettingsController < ApplicationController
  def new
    @notification_setting = NotificationSetting.new
  end

  def create
    @notification_setting = current_user.notification_settings.new(notification_setting_params)
    if @notification_setting.save
      send_time = @notification_setting.send_time
      # 下記コードにより、send_time時間になるとSendLineMessageJobが実行される。
      SendLineMessageJob.set(wait_until: send_time).perform_later(@notification_setting.id, current_user.id)
      DestroyNotificationSettingJob.set(wait_until: send_time + 1.minutes).perform_later(@notification_setting.id)
      redirect_to new_question_path, notice: t('.success')
    else
      flash.now[:fail] = t('.fail')
      render :new
    end
  end


  private

  def notification_setting_params
    params.require(:notification_setting).permit(:send_daily, :send_time)
  end

end
