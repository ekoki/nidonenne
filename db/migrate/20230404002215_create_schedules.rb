class CreateSchedules < ActiveRecord::Migration[7.0]
  def change
    create_table :schedules do |t|
      t.references :user, null: false, foreign_key: true
      t.datetime :wake_up_time, null: false
      t.datetime :bedtime, null: false
      t.boolean :got_up

      t.timestamps
    end
  end
end
