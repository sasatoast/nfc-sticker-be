class Song < ApplicationRecord
  after_create { ShareSongService.create_password(self) }
  belongs_to :artist
  has_many :users_shared_songs
  has_many :shared_counts, dependent: :destroy
end
