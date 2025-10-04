class ShareSongService
  def initialize(song_id:,share_id: nil)
    @song_id = song_id
    @share_id = share_id
  end

  def self.fetch_song_and_artist_name(song_id)
    song = Song.includes(:artist).find_by(id: song_id)
    return nil unless song
      {
        id: song.id,
        source_url: song.source_url,
        picture_url: song.picture_url,
        spotify_url: song.spotify_url,
        apple_url: song.apple_url,
        artist_name: song.artist&.name
      }
  end

  def increment_shared_count
    shared_count = SharedCount.find_or_initialize_by(
      song_id: @song_id,
      share_id: @share_id
      )
    shared_count.count += 1
    shared_count.save
  end
end
