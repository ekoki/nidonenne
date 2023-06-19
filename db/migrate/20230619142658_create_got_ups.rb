class CreateGotUps < ActiveRecord::Migration[7.0]
  def change
    create_table :got_ups do |t|
      t.boolean :got_up, null: false
      t.timestamps
    end
  end
end
