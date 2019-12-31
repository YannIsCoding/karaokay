class AddPlayerAndPlaylistReferencesToVotes < ActiveRecord::Migration[6.0]
  def change
    add_reference :votes, :player, foreign_key: true
    add_reference :votes, :playlist, foreign_key: true
  end
end
