Rails.application.routes.draw do
  # root path
  root "sessions#new"

  #Users path
  get '/signup' => 'users#new'
  post '/users' => 'users#create'

  #sessions Path
  get '/login' => 'sessions#new'
  post '/login' => 'sessions#create'
  get '/logout' => 'sessions#destroy'
  resources :blogs


  namespace :api do
    resources :blogs
    get '/signup' => 'users#new'
    post '/users' => 'users#create'
  
    #sessions Path
    get '/login' => 'sessions#new'
    post '/login' => 'sessions#create'
    get '/logout' => 'sessions#destroy'
  end
  

end

