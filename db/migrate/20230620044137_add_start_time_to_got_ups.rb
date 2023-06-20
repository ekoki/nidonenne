class AddStartTimeToGotUps < ActiveRecord::Migration[7.0]
  def change
    add_column :got_ups, :start_time, :datetime
  end
end
