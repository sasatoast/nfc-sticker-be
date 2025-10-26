class Artist
  class SharedArtistFetcher
    include Callable
    def initialize(user_id:)
      @user_id = user_id
    end

    def call
      fetch_shared_artist(@user_id)
    end

    def fetch_shared_artist(user_id)
      shared_artists_ids = UsersSharedSong.where(user_id: user_id).pluck(:artist_id)
      artists = Artist.where(id: shared_artists_ids)
      
      if artists.empty?
        [ :not_found, nil ]
      else
        result = artists.map do |artist|
          {
            artist_id: artist.id,
            artist_name: artist.name,
            artist_picture_url: artist.picture_url
          }
        end
        [ :ok, result ]
      end
    end
  end
end