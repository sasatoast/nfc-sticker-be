class SharedCount < ApplicationRecord
  belongs_to :song
  belongs_to :user, foreign_key: :share_id, primary_key: :share_id
end
