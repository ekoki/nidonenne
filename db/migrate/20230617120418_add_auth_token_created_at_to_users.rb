class AddAuthTokenCreatedAtToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :auth_token_created_at, :datetime
  end
end
