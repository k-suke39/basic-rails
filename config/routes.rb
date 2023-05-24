Rails.application.routes.draw do
  root :to => "staticpages#top"

  get 'users/new' => "users#new"
  get 'login' => "user_sessions#new"

end
