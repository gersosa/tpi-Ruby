class AddTokenCreatedAtToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :token_created_at, :datetime
  end
end
