Rails.application.routes.draw do
  mount Ckeditor::Engine => '/ckeditor'
  root to: "static_pages#home"

  # Articles

  get "/learn", to: "articles#index", as: "articles"
  get "/learn/:game_slug", to: "articles#game_index", as: "game_articles"
  get "/learn/:game_slug/c/:character_slug", to: "articles#character_index", as: "character_articles"
  get "/learn/:game_slug/c/:character_slug/frame-data", to: "articles#character_frame_data", as: "character_frame_data"
  get "/learn/:game_slug/c/:character_slug/combos", to: "articles#character_combos", as: "character_combos"

  get "/article/:article_slug", to: "articles#show"
  get "/article/:id/edit", to: "articles#edit"
  get "/article/new", to: "articles#new"

  get "/game/character", to: "articles#character_index"
  get "/game/character/frame-data", to: "articles#character_frame_data"
end
