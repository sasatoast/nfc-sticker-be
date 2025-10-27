Rails.application.routes.draw do
  mount Rswag::Api::Engine => "/api-docs"
  mount Rswag::Ui::Engine => "/api-docs"
      devise_for :users, path: "", path_names: {
        sign_in: "login",
        sign_out: "logout",
        registration: "signup"
      },
      controllers: {
        sessions: "users/sessions",
        registrations: "users/registrations"
      }
      get "player/songs/:id", to: "songs/songs#show"
      get "users/received/songs", to: "songs/songs#show_received_song"
      post "users/songs/:song_id/unlock", to: "songs/songs#register_sharable_song"
      post "songs", to: "songs/songs#create_song"
      get "users/songs", to: "songs/songs#show_sharable_song"
      get "users/shared/songs", to: "songs/songs#show_shared_song"
      get "ranking/:artist_id", to: "songs/songs#show_share_ranking_by_artist_id"
      get "artists/shared", to: "artists/artists#index_shared_artist"
      get "artists/:artist_id", to: "artists/artists#show_artist"
      get "songs/:song_id/share_url", to: "songs/songs#generate_share_url"
end
