Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  # Defines the root path route ("/")
  root "pages#home"
  get "pages/home", to: "pages#home"
  get "/signup", to: "chefs#new"
  resources :recipes do
    resources :comments , only: [:create]
    member do
      post 'like'
    end
  end

  resources :chefs , except: [:new]

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  resources :ingredients, except: [:destroy]

  # mount ActionCable.server => '/cable'

  get '/chat', to: 'chatrooms#show'
  resources :messages, only: [:create]

end
