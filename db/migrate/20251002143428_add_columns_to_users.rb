class AddColumnsToUsers < ActiveRecord::Migration[8.0]
  def change
    add_column :users, :name, :string
    add_column :users, :share_id, :string
    add_column :users, :mail, :string
  end
end
