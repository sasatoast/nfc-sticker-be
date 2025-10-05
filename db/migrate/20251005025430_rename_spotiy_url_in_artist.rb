class RenameSpotiyUrlInArtist < ActiveRecord::Migration[8.0]
  def change
    rename_column :artists, :sporify_url, :spotify_url
    # Ex:- rename_column("admin_users", "pasword","hashed_pasword")
  end
end
