Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  # get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
<<<<<<< HEAD
  resources :questionnaires, only: [:new, :create, :show]
=======

  resources :questionnaires
  resources :questions do
    resources :answers #, only: [:new, :create]
  end
>>>>>>> 2552bc3f540f39e147e9077a0eaa99f2ae8cb5ad
end
