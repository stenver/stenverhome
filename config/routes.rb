StenverHome::Application.routes.draw do
  get "comments/new"
  get "comments/create"
  get "comments/edit"
  get "comments/update"
  resources :sessions, only: [:new, :create, :destroy]
  resources :users
  resources :articles
  root  'articles#index'

  match '/coolStuff', to: 'public#coolStuff',    via: 'get'
  match '/experience', to: 'public#experience',   via: 'get'
  match '/about', to: 'public#about', via: 'get'

  match '/signup', to: 'users#new', via: 'get'

  match '/signin', to: 'sessions#new', via: 'get'
  match '/sessions', to: 'sessions#create', via: 'post'
  match '/signout', to: 'sessions#destroy', via: 'delete'
end
