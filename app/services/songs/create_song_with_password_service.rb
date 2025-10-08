module Songs
  class CreateSongWithPasswordService
    include Callable
    def initialize(
      name:,
      source_url:,
      picture_url:,
      spotify_url: nil,
      apple_url: nil,
      artist_name:
    )
    @name = name
    @source_url = source_url
    @picture_url = picture_url
    @spotify_url = spotify_url
    @apple_url = apple_url
    @artist_name = artist_name
    end

    def call
      add_song(@name, @source_url, @picture_url, @spotify_url, @apple_url, @artist_name)
    end

    def add_song(name, source_url, picture_url, spotify_url, apple_url, artist_name)
      password = SecureRandom.hex(4)
      artist = Artist.find_by!(name: artist_name)
      ActiveRecord::Base.transaction do
      song = Song.create!(
        name: name,
        source_url: source_url,
        picture_url: picture_url,
        spotify_url: spotify_url,
        apple_url: apple_url,
        artist: artist
      )

      SongsPassword.create!(
        song_id: song.id,
        password: password
      )
      end
    [ :ok, password ]

    rescue ActiveRecord::RecordInvalid => e
    [ :error, e.record.errors.full_messages ]
    end
  end
end
