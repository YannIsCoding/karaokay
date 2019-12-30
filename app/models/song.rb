class Song < ActiveRecord::Base
  has_many :playlists
  has_many :karaokes, through: :playlists
end
