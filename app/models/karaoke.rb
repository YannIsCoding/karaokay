class Karaoke < ActiveRecord::Base
  belongs_to :user

  has_many :playlists
  has_many :players
  has_many :songs, through: :playlists
end
