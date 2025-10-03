class AddUniqueIndexToShareIdOnUsers < ActiveRecord::Migration[8.0]
  def change
    add_index :users, :share_id, unique: true
  end
end
