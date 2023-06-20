class DestroyNotificationSettingJob < ApplicationJob
  queue_as :default

  def perform(*args)
    notification_setting = NotificationSetting.find(args[0])
    notification_setting.destroy!
  end
end
