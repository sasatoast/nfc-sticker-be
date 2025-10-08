class Songs::SongsController < ApplicationController
  include Devise::Controllers::Helpers
  before_action :authenticate_user!, only: [ :show_shared_song, :register_sharable_song, :show_sharable_song]
  # あとでここにcreate_song追加
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
    shared_song_data = FetchSharedSongsService.call(
      user_id: current_user&.id
    )
    if shared_song_data.present?
      render json: shared_song_data, status: :ok
    else
      render json: { shared_song_data: [], "message": "共有された曲はまだありません" }, status: :ok
    end
  end

  def register_sharable_song
    status, result = RegisterShareSongService.call(
      user_id: current_user&.id,
      song_id: params[:song_id],
      password: params[:password]
    )
    case status
    when :ok
      render json: { data: result }
    when :error
      render json: { error_code: result }
    end
  end

  def create_song
    status, result = CreateSongWithPasswordService.call(
      name: params[:name],
      source_url: params[:source_url],
      picture_url: params[:picture_url],
      spotify_url: params[:spotify_url],
      apple_url: params[:apple_url],
      artist_name: params[:artist_name]
    )
    case status
    when :ok
      render json: { data: result }
    when :error
      render json: { data: result }
    end
  end

  def show_sharable_song
    songs_data = SharableSongsService.call(
      user_id: current_user.id
    )
    if songs_data.present?
      render json: songs_data
    else
      render json: {"message": "共有できる曲はまだありません"}
    end
  end

end
