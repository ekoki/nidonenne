class AddUserIdToGotUps < ActiveRecord::Migration[7.0]
  def change
    add_reference :got_ups, :user, null: false, foreign_key: true
  end
end
