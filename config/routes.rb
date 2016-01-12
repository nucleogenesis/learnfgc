Rails.application.routes.draw do
  root to: "static_pages#home"
  get "/game", to: "articles#game_index"
end
