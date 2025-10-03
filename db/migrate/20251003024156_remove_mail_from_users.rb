class RemoveMailFromUsers < ActiveRecord::Migration[8.0]
  def change
    remove_column :users, :mail, :string
  end
end
