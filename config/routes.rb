Rails.application.routes.draw do
  mount Ckeditor::Engine => '/ckeditor'
  root to: "static_pages#home"

  resources :articles

  resources :game, only: [:show], controller: 'games' do
    resources :character, only: [:show], controller: 'characters' do
      member do
        get 'frame-data', to: 'characters#frame_data'
        get 'combos',     to: 'characters#combos'
      end
    end
  end



  ### Learn / Articles ###
  #
  # Index Routes
  #get       '/learn',                               to: 'articles#index',       as: 'article_index'
  #get       '/learn/:game_slug',                    to: 'games#index',          as: 'game'
  #get       '/learn/:game_slug/:character_slug',    to: 'characters#index',     as: 'character'
  # Article Routes
  #get       '/a/:article_slug',                     to: 'articles#show',        as: 'article'
  #post      '/a',                                   to: 'articles#create'
  #get       '/a/new',                               to: 'articles#new',         as: 'new_article'
  #get       '/a/:article_slug/edit',                to: 'articles#edit',        as: 'edit_article'
  #delete    '/a/:article_slug',                     to: 'articles#destroy'
  #put       '/a/:article_slug',                     to: 'articles#update'
  #patch     '/a/:article_slug',                     to: 'articles#update'
  # Character Routes [Non-Index]
  #get '/learn/:game_slug/:character_slug/frame-data',  to: 'characters#frame_data', as: 'character_frame_data'
  #get '/learn/:game_slug/:character_slug/combos',      to: 'characters#combos',     as: 'character_combos'


  #get "/learn", to: "articles#index", as: "articles"
  #get "/learn/:game_slug", to: "articles#game_index", as: "game_articles"
  #get "/learn/:game_slug/c/:character_slug", to: "articles#character_index", as: "character_articles"
  #get "/learn/:game_slug/c/:character_slug/frame-data", to: "articles#character_frame_data", as: "character_frame_data"
  #get "/learn/:game_slug/c/:character_slug/combos", to: "articles#character_combos", as: "character_combos"
  #
  #get "/article/:article_slug", to: "articles#show"
  #get "/article/:id/edit", to: "articles#edit"
  #get "/article/new", to: "articles#new"
  #
  #get "/game/character", to: "articles#character_index"
  #get "/game/character/frame-data", to: "articles#character_frame_data"
end
