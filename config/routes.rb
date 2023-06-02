Rails.application.routes.draw do
  root :to => "staticpages#top"
  
  get    'login' => "user_sessions#new"
  post   'login' => "user_sessions#create"
  delete 'logout' => "user_sessions#destroy"
  
  namespace :admin do
    root to: 'dashboards#index'
    get 'login', to: 'user_sessions#new'
    post 'login', to: 'user_sessions#create'
    delete 'logout', to: 'user_sessions#destroy'
    resources :users
    resources :boards
  end

  resources :users, only: %i[new create]
  resources :boards do
    collection do
      get 'bookmarks'
    end
    resources :comments, only: %i[new create destroy], shallow: true
    resource :bookmarks, only: %i[create destroy], shallow: true
  end

  resources :password_resets, only: %i[new create edit update]

  resource :profile

  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?
end
