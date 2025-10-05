class PlaySongService
  include Callable
  # require 'pry-rails'
    def initialize(song_id:, user_id: nil, share_id: nil)
      @song_id = song_id
      @user_id = user_id
      @share_id = share_id
    end

    def call
      song = fetch_song_and_artist_name(@song_id)
      return nil unless song
      if @share_id.present?
        increment_shared_count
      end
      if @user_id.present?
        save_shared_song
      end
      # binding.irb
      song
    end

    private
    def fetch_song_and_artist_name(song_id)
      song = Song.includes(:artist).find_by(id: song_id)
      return nil unless song
        {
          id: song.id,
          source_url: song.source_url,
          picture_url: song.picture_url,
          spotify_url: song.spotify_url,
          apple_url: song.apple_url,
          artist_name: song.artist&.name,
          artist_id: song.artist_id
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

    def save_shared_song
      shared_song = UsersSharedSong.find_or_initialize_by(
        user_id: @user_id,
        song_id: @song_id
        )
      shared_song.save
    end
end
