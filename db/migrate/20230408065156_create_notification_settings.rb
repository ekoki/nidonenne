class CreateNotificationSettings < ActiveRecord::Migration[7.0]
  def change
    create_table :notification_settings do |t|
      t.references :user, null: false, foreign_key: true
      t.boolean :send_daily, null: false, default: false
      t.datetime :send_time, null: false

      t.timestamps
    end
  end
end
