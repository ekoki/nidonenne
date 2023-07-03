class ChangeSendTimeToTimeInNotificationSettings < ActiveRecord::Migration[7.0]
  def up
    change_column :notification_settings, :send_time, :time
  end

  def down
    change_column :notification_settings, :send_time, :datetime
  end
end
