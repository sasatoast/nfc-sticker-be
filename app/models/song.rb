class Song < ApplicationRecord
  belongs_to :artist
  has_many :users_shared_songs
  has_many :shared_counts, dependent: :destroy
  has_many :songs_passwords, dependent: :destroy
end
