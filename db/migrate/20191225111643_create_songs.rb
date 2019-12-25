class CreateSongs < ActiveRecord::Migration[6.0]
  def change
    create_table :songs do |t|
      t.string :title
      t.integer :duration
      t.string :genre
      t.string :artist
      t.string :album_name
      t.timestamps null: false
    end
  end
end
