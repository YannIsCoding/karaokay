class Vote < ActiveRecord::Base
  belongs_to :player
  belongs_to :playlist
end
