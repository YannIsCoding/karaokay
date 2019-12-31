class AddUserAndKaraokeRefrencesToPlayers < ActiveRecord::Migration[6.0]
  def change
    add_reference :players, :user, foreign_key: true
    add_reference :players, :karaoke, foreign_key: true
  end
end
