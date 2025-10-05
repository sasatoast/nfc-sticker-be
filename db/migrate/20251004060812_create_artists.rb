class CreateArtists < ActiveRecord::Migration[8.0]
  def change
    create_table :artists do |t|
      t.string :picture_url
      t.string :sporify_url
      t.string :apple_url
      t.string :homepage_url

      t.timestamps
    end
  end
end
