Rails.application.routes.draw do
  root to: "static_pages#home"
  get "/game", to: "static_pages#game_index"
end
