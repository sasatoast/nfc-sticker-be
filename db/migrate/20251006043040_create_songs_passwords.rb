class CreateSongsPasswords < ActiveRecord::Migration[8.0]
  def change
    create_table :songs_passwords do |t|
      t.references :songs, null: false, foreign_key: true
      t.string :password_digest

      t.timestamps
    end
  end
end
