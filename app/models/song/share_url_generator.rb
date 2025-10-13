class Song
  class ShareUrlGenerator
    include Callable
    def initialize(song_id:, share_id:)
      @song_id = song_id
      @share_id = share_id
    end

    def call
      generate_share_url(@song_id, @share_id)
    end

    def generate_share_url(song_id, share_id)
      "https://localhost:3001/player/#{song_id}?share_id=#{share_id}"
    end
  end
end
