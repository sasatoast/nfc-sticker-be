class Song < ApplicationRecord
  belongs_to :artist
  has_many :UsersSharedSong
end
