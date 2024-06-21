Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
  post 'auth/login', to: 'authentication#login'
  post 'auth/signup', to: 'authentication#signup'

  resources :categories, only: [:index, :show]
  resources :articles, only: %i[index show]

  resource :cart, only: [:show] do
    post 'add_item', to: 'carts#add_item'
    delete 'remove_item/:id', to: 'carts#remove_item', as: 'remove_item'
  end
end
