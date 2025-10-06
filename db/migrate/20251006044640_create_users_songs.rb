class CreateUsersSongs < ActiveRecord::Migration[8.0]
  def change
    create_table :users_songs do |t|
      t.references :users, null: false, foreign_key: true
      t.references :songs, null: false, foreign_key: true

      t.timestamps
    end
  end
end
