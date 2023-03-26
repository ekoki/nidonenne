class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :name, nill: false
      t.string :email, nill: false
      t.string :crypted_password
      t.string :salt
      t.string :reset_password_token
      t.datetime :reset_password_token_expires_at
      t.datetime :reset_password_email_sent_at

      t.timestamps
    end
  end
end
