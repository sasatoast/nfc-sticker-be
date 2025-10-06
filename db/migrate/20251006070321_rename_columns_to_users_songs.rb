class RenameColumnsToUsersSongs < ActiveRecord::Migration[8.0]
  def change
    rename_column :users_songs, :songs_id, :song_id
    rename_column :users_songs, :users_id, :user_id
    #Ex:- rename_column("admin_users", "pasword","hashed_pasword")
  end
end
