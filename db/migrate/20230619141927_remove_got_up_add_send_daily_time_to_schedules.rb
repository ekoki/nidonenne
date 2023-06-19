class RemoveGotUpAddSendDailyTimeToSchedules < ActiveRecord::Migration[7.0]
  def change
    remove_column :schedules, :got_up, :boolean
    add_column :schedules, :send_daily_time, :time
  end
end
