class CreateSharedCounts < ActiveRecord::Migration[8.0]
  def change
    create_table :shared_counts do |t|
      t.string :share_id, null: false
      t.references :song, null: false, foreign_key: true
      t.integer :count, null: false, default: 0

      t.timestamps
    end
    add_index :shared_counts, [:share_id,:song_id], unique: true
  end
end
