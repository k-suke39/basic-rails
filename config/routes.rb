Rails.application.routes.draw do
  root :to => "staticpages#top"
  
  get 'login' => "user_sessions#new"
  resources :users, only: %i[new create]

end
