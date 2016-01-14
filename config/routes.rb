Rails.application.routes.draw do
  mount Ckeditor::Engine => '/ckeditor'
  root to: "static_pages#home"
  get "/game", to: "articles#game_index"
  get "/game/character", to: "articles#character_index"
  get "/game/character/frame-data", to: "articles#character_frame_data"
  get "/article", to: "articles#show"
  get "/article/new", to: "articles#new"
end
