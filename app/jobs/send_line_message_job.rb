class SendLineMessageJob < ApplicationJob
require 'line/bot'

  def perform(*args)
    queue_as :default
    send_push_message_by_notification_setting_id(arg[0])
  end

  private

  def send_push_message_by_notification_setting_id(notification_setting_id)
    notification = NotificationSetting.find(notification_setting_id)
    message = {
      type: 'text',
      text: create_line_message(notification)
    }
    notification.user.line_users.each do |line_user|
      client.push_message(line_user.line_user_id, message)
    end
  end

  def client
    @client ||= Line::Bot::Client.new { |config|
      config.channel_secret = ENV["LINE_CHANNEL_SECRET"]
      config.channel_token = ENV["LINE_CHANNEL_TOKEN"]
    }
  end
end
