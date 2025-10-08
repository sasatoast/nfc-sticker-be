class FetchShareRanking
  include Callable
  def initialize(artist_id:)
    @artist_id = artist_id
  end

  def call
    fetch_raking(@artist_id)
  end

  def fetch_raking(artist_id)
    results = SharedCount
        .joins(:user, :song)
        .where(songs: { artist_id: artist_id })
        .select(
          "users.name AS user_name,
          songs.name AS song_name,
          song.picture_url AS picture_url,
          shared_counts.count AS shared_count"
        )
        .order("shared_counts.count DESC")
        .limit(3)
    results.map do |data|
      {
        user_name: data.user_name,
        song_name: data.song_name,
        picture_url: data.picture_url,
        count: shared_count
      }
    end
  end
end
