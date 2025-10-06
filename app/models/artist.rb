class Artist < ApplicationRecord
  has_many :song, dependent: :destroy
end
