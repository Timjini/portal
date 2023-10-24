Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  root "dashboard#index"


  resources :athlete_profiles, only: [:new, :create, :index ,:show ,:edit, :update]
  # get '/athlete_users/:id' , to: 'athlete_profiles#athlete_users'
  get 'athlete_users/autocomplete', to: 'athlete_profiles#autocomplete'
  get 'users/:id' , to: 'users#show'
  get'goals_rewards_achievements', to: 'dashboard#goals_rewards_achievements'

  #search 
  post 'search' , to: 'search#index', as: 'search'
  post 'search/suggestions' , to: 'search#suggestions', as: 'search_suggestions'

  

  get '/dashboard' , to: "dashboard#index"

end
