class ChangeNotificationSettings < ActiveRecord::Migration[7.0]
  def change
    remove_column :notification_settings, :send_daily, :boolean
    add_column :notification_settings, :notification_schedule, :integer, default: 0, null: false
  end
end
