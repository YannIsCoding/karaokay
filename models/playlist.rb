class Playlist < ActiveRecord::Base
  belongs_to :karaoke
  belongs_to :song
end
