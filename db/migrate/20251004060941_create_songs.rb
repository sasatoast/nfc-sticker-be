class CreateSongs < ActiveRecord::Migration[8.0]
  def change
    create_table :songs do |t|
      t.string :name
      t.string :source_url
      t.string :picture_url
      t.string :spotify_url
      t.string :apple_url
      t.references :artist, null: false, foreign_key: true

      t.timestamps
    end
  end
end
