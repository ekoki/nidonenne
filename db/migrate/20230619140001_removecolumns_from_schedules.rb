class RemovecolumnsFromSchedules < ActiveRecord::Migration[7.0]
  def change
    remove_column :schedules, :wake_up_time, :datetime
    remove_column :schedules, :bedtime, :datetime
  end
end
