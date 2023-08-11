class CreateNonces < ActiveRecord::Migration[7.0]
  def change
    create_table :nonces do |t|
      t.string :nonce
      t.integer :user_id

      t.timestamps
    end
  end
end
