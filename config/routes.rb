Rails.application.routes.draw do
  
  root 'static#home'

  scope :users do 
      get '/new', to: 'users#new', as: 'new_user'
      get '/', to:'users#index', as: 'users'
      post '/', to:'users#create'
      get '/:id', to: 'users#show', as: 'user'
      get '/:id/edit', to: 'users#edit', as: 'edit_user'
  end

  scope :attractions do
        get '/', to: 'attractions#index', as: 'attractions'
        get '/new', to: 'attractions#new', as: 'new_attraction'
        get '/:id', to: 'attractions#show', as: 'attraction'
        get '/:id/edit', to: 'attractions#edit', as: 'edit_attraction'
        patch '/:id', to: 'attractions#update'
        post '/', to: 'attractions#create'
  end

  post '/rides', to:"rides#create", as: 'rides'

  get '/signin', to: 'session#new', as: 'signin'
  post '/session', to: 'session#create', as: 'session'
  delete '/session/', to: 'session#destroy'
  
end
