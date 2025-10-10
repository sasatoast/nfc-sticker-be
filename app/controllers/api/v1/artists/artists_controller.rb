module Api
  module V1
    class Artists::ArtistsController < ApplicationController
      skip_before_action :authenticate_user!, only: [ :show_artist ]

      def show_artist
        status, result = Artist::ArtistFetcher.call(
          artist_id: params[:artist_id]
        )
        case status
        when :ok
          render json: result
        when :not_found
          render json: { error: "Artist not found" }, status: :not_found
        end
      end
    end
  end
end
