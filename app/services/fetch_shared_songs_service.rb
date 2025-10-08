class FetchSharedSongsService
  include Callable
  def initialize(share_id:)
    @share_id = share_id
  end

  def call
    fetch_songs(@share_id)
  end

  def fetch_songs(share_id)
    count_data = SharedCount.where(share_id: share_id).includes(song: :artist)
    count_data.map do |data|
      song = data.song
      {
        "name": song.name,
        "artist_name": song.artist.name,
        "count": data.count,
        "song_id": song.id
      }
    end
  end
end
