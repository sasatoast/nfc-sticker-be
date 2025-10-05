class AddColumnArtist < ActiveRecord::Migration[8.0]
  def change
    add_column :artists, :name, :string
  end
end
