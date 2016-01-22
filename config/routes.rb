Rails.application.routes.draw do
  get 'questions/index'

  get 'questions/create'

  get 'questions/new'

  get 'questions/edit'

  get 'questions/show'

  get 'questions/update'

  get 'questions/destroy'

  get 'question_comments/index'

  get 'question_comments/create'

  get 'question_comments/new'

  get 'question_comments/edit'

  get 'question_comments/show'

  get 'question_comments/update'

  get 'question_comments/destroy'

  get 'revision_comments/index'

  get 'revision_comments/create'

  get 'revision_comments/new'

  get 'revision_comments/edit'

  get 'revision_comments/show'

  get 'revision_comments/update'

  get 'revision_comments/destroy'

  get 'revisions/index'

  get 'revisions/create'

  get 'revisions/new'

  get 'revisions/edit'

  get 'revisions/show'

  get 'revisions/update'

  get 'revisions/destroy'

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
    resources :questions do
      resources :question_comments
    end
    resources :revisions do
      resources :revision_comments
    end
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
