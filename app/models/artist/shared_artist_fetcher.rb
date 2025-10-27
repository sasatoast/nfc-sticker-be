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
      # JOINを使って1つのクエリで効率的に取得
      artists = Artist
        .joins(songs: :users_shared_songs)
        .where(users_shared_songs: { user_id: user_id })
        .distinct

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
