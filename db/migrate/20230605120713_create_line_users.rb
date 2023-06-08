class CreateLineUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :line_users do |t|
      t.string :line_user_id, null: false
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
