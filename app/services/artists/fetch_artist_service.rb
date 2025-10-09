module Artists
  class FetchArtistService
    include Callable
    def initialize(artist_id:)
      @artist_id = artist_id
    end

    def call
      fetch_artist(@artist_id)
    end

    def fetch_artist(artist_id)
      artist = Artist.find_by(id: artist_id)
      if artist.present?
        [
          :ok,
          {
            name: artist.name,
            picture_url: artist.picture_url,
            spotify_url: artist.spotify_url,
            apple_url: artist.apple_url,
            homepage_url: artist.homepage_url
          }
        ]
      else
        [ :not_found, nil ]
      end
    end
  end
end
