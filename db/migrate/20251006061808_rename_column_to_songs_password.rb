class RenameColumnToSongsPassword < ActiveRecord::Migration[8.0]
  def change
    rename_column :songs_passwords, :songs_id, :song_id
    # Ex:- rename_column("admin_users", "pasword","hashed_pasword")
  end
end
