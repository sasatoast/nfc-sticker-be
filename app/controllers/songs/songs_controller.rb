class Songs::SongsController < ApplicationController
  def show
    song_data = FetchSongService.call(
      song_id: params[:id],
      share_id: params[:share_id]
    )
    if song_data
      render json: song_data, status: :ok
    else
      render json: { error: "Song not found" }, status: :not_found
    end
  end
end
