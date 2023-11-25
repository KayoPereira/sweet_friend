Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  resources :events do
    resources :draws, only: [ :index, :create, :destroy ]
    post "/raffle", to: "draws#raffle"
    patch "/drawn", to: 'draws#drawn'
  end
end
