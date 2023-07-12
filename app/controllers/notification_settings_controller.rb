class NotificationSettingsController < ApplicationController
  def new
    @notification_setting = NotificationSetting.new
    @delete_notification = NotificationSetting.find_by(user_id: current_user.id)
  end

  def create
    @notification_setting = current_user.notification_settings.new(notification_setting_params)
    @current_time = Time.current
    if @notification_setting.save
      send_time = @notification_setting.send_time
      # 下記コードにより、send_time時間になるとSendLineMessageJobが実行される。
      SendLineMessageJob.set(wait_until: send_time).perform_later(@notification_setting.id, current_user.id, @notification_setting.notification_schedule)
      if @notification_setting.notification_schedule == NotificationSetting.notification_schedules.keys[0]
        DestroyNotificationSettingJob.set(wait_until: send_time + 1.minutes).perform_later(@notification_setting.id)
      end
      redirect_to new_question_path, notice: t('.success')
    else
      flash.now[:alert] = t('.fail')
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    notification = NotificationSetting.find(params[:id])
    notification.destroy
    redirect_to new_notification_setting_path, notice: t('.success'), status: :see_other
  end


  private

  def notification_setting_params
    params.require(:notification_setting).permit(:notification_schedule, :send_time)
  end

end
