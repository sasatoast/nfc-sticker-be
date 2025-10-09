module Songs
  class RegisterShareSongService
    include Callable
    def initialize(user_id:, song_id:, password:)
        @user_id = user_id
        @song_id = song_id
        @password = password
    end

    def call
      register_song(@user_id, @song_id, @password)
    end

    def register_song(user_id, song_id, password)
        password_setting = SongsPassword.find_by(song_id: song_id)
        if password_setting&.authenticate(password)
          song = UsersSong.create!(user_id: user_id, song_id: song_id)
          [ :ok, song ]
        else
          [ :error, :wrong_password ]
        end
    end
  end
end
