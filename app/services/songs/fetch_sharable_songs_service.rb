module Songs
  class FetchSharableSongsService
    include Callable
    def initialize(user_id:)
      @user_id = user_id
    end

    def call
      fetch_song(@user_id)
    end

    def fetch_song(user_id)
      songs = UsersSong.where(user_id: user_id).includes(song: :artist)
      songs.map do |fetch_song|
        song = fetch_song.song
        artist = song.artist
        {
          song_id: song.id,
          song_name: song.name,
          artist_name: artist.name,
          song_picture_url: song.picture_url
        }
      end
    end
  end
end
