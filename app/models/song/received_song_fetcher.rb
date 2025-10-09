class Song
  class ReceivedSongFetcher
    include Callable
    def initialize(user_id:)
      @user_id = user_id
    end

    def call
      fetch_received_songs_by_user_id(@user_id)
    end

    def fetch_received_songs_by_user_id(user_id)
      received_songs_ids = UsersSharedSong.where(user_id: user_id).pluck(:song_id)
      songs_with_artist = Song.where(id: received_songs_ids).includes(:artist)
      songs_with_artist.map do |song|
        {
          song_id: song.id,
          song_name: song.name,
          song_picture_url: song.picture_url,
          artist_name: song.artist.name
        }
      end
    end
  end
end
