class SongController < ApplicationController
  def show
    @song_id = params[:id]
    @share_id = params[:share_id]

    service = ShareSongService.new(song_id: @song_id, share_id: @share_id)

    song = service.fetch_song_and_artist_name(@song_id)
    render json: song

    service.increment_shared_count
  end
end
