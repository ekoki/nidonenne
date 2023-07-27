namespace :notification_schedule do

  desc 'ユーザーが指定した時間にメッセージを送信する(毎日、平日のみ、週末のみ)'
  task send_message: :environment do
      NotificationSetting.notification_daily_within_one_hour.each do |notification|
        SendLineMessageJob.set(wait_until: notification.send_time).perform_later(notification.id, notification.user_id)
      end

      if Date.today.on_weekday?
        NotificationSetting.notification_weekday_within_one_hour.each do |notification|
          SendLineMessageJob.set(wait_until: notification.send_time).perform_later(notification.id, notification.user_id)
        end
      end

      if Date.today.on_weekend?
        NotificationSetting.notification_weekend_within_one_hour.each do |notification|
          SendLineMessageJob.set(wait_until: notification.send_time).perform_later(notification.id, notification.user_id)
        end
      end

      binding.break

  end

  
end
