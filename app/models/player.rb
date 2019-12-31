class Player < ActiveRecord::Base
  belongs_to :user
  belongs_to :karaoke

  has_many :votes
end
