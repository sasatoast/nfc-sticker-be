class SongsPassword < ApplicationRecord
  has_secure_password
  belongs_to :song
end
