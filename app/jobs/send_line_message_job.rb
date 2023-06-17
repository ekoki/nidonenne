class SendLineMessageJob < ApplicationJob
  require 'line/bot'
  queue_as :default

  def perform(*args)
    current_user = User.find_by(args[1])
    send_push_message_by_notification_setting_id(args[0], current_user)
  end

  private

  def send_push_message_by_notification_setting_id(notification_setting_id, current_user)
    notification = NotificationSetting.find_by(id: notification_setting_id)
    return unless notification # handle not found case

    message = {
      type: 'text',
      text: send_message(notification, current_user)
    }
    
    notification.user.line_users.each do |line_user|
      begin
        client.push_message(line_user.line_user_id, message)
      rescue => e
        Rails.logger.error "Failed to send message: #{e.message}"
      end
    end
  end

  def client
    @client ||= Line::Bot::Client.new do |config|
      config.channel_secret = ENV["LINE_CHANNEL_SECRET"]
      config.channel_token = ENV["LINE_CHANNEL_TOKEN"]
    end
  end

  def send_message(notification, current_user)
    message = "おはようございます！\n本日の問題を送信します。\n"
    message << Rails.application.routes.url_helpers.new_user_answer_form_url(current_user, host: 'glacial-dusk-80037.herokuapp.com')

    message
  end
end
