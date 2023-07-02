class NotificationSettingsController < ApplicationController
  def new
    @notification_setting = NotificationSetting.new
  end

  def create
    @notification_setting = current_user.notification_settings.new(notification_setting_params)
    @current_time = Time.current
    if @notification_setting.save
      send_time = @notification_setting.send_time
      case @notification_setting.notification_schedule
      when @notification_setting.daily?
        SendLineMessageJob.set(wait_until: send_time).perform_later(@notification_setting.id, current_user.id)
      when @notification_setting.weekday?
        SendLineMessageJob.set(wait_until: send_time).perform_later(@notification_setting.id, current_user.id)
      when @notification_setting.weekend?
        SendLineMessageJob.set(wait_until: send_time).perform_later(@notification_setting.id, current_user.id)
      else
        # 下記コードにより、send_time時間になるとSendLineMessageJobが実行される。
        SendLineMessageJob.set(wait_until: send_time).perform_later(@notification_setting.id, current_user.id)
        # DestroyNotificationSettingJob.set(wait_until: send_time + 1.minutes).perform_later(@notification_setting.id)
        redirect_to new_question_path, notice: t('.success')
      end
    else
      flash.now[:alert] = t('.fail')
      render :new, status: :unprocessable_entity
    end
  end

  def update

  end


  private

  def notification_setting_params
    params.require(:notification_setting).permit(:notification_schedule, :send_time)
  end

end
