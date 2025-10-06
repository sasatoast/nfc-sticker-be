class RegistSongService
  include Callable
  def initialize
  end

  def self.create_password(song)
    SongsPassword.create!(
      song_id: song.id,
      password: SecureRandom.hex(4)
    )
  end
end
