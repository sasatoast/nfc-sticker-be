class Songs::SongsController < ApplicationController
  before_action :authenticate_user!, only: [ :show_shared_song ]
  def show
    song_data = PlaySongService.call(
      song_id: params[:id],
      share_id: params[:share_id],
      user_id: current_user&.id
    )
    if song_data
      render json: song_data, status: :ok
    else
      render json: { error: "Song not found" }, status: :not_found
    end
  end

  def show_shared_song
    shared_song_data = SharedSongsService.call(
      user_id: current_user&.id
    )
    if shared_song_data.present?
      render json: shared_song_data, status: :ok
    else
      render json: { shared_song_data: [], "message": "共有された曲はまだありません" }, status: :ok
    end
  end
end
