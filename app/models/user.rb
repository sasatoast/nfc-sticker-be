class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :validatable,
         :jwt_authenticatable, jwt_revocation_strategy: :jwt_denylist
  before_create :generate_share_id

  has_many :users_shared_songs
  private

  def generate_share_id
    loop do
      self.share_id = SecureRandom.hex(8)
      break unless User.exists?(share_id: self.share_id)
    end
  end
end
