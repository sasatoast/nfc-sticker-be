Rails.application.routes.draw do
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
      get "users/shared/songs", to: "songs/songs#show_shared_song"
      post "users/songs/:song_id/unlock", to: "songs/songs#register_sharable_song"
      post "songs", to: "songs/songs#create_song"
      get "users/songs", to: "songs/songs#show_sharable_song"
end
