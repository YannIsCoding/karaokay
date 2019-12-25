class AddPlaylistToKaraoke < ActiveRecord::Migration[6.0]
  def change
    add_reference :karaokes, :playlist, foreign_key: true
  end
end
