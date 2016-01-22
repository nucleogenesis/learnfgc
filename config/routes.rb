Rails.application.routes.draw do
  mount Ckeditor::Engine => '/ckeditor'
  root to: "static_pages#home"

  resources :passwords, controller: 'clearance/passwords', only: [:create, :new]
  resources :session, controller: 'clearance/session', only: [:create]
  resources :users,
    controller: 'clearance/users',
    only: Clearance.configuration.user_actions do
      resource :password,
        controller: 'clearance/passwords',
        only: [:create, :edit, :update]
    end

  resources :articles do
    resources :questions
    resources :revisions
  end

  resources :game, only: [:show], controller: 'games' do
    resources :character, only: [:show], controller: 'characters' do
      member do
        get 'frame-data', to: 'characters#frame_data'
        get 'combos',     to: 'characters#combos'
      end
    end
  end
end
