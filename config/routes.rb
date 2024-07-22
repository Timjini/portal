Rails.application.routes.draw do
  resources :time_slots
   resources :coach_calendar, only: [:index, :create, :update, :destroy, :show] do 
    get 'data/:user_id', on: :collection, to: 'coach_calendar#calendar_data'
    get 'data', on: :collection, to: 'coach_calendar#all_calendars'
    get 'coach_calendar/:user_id', on: :collection , to: 'coach_calendars#show'
    get 'coach_calendar', on: :collection , to: 'coach_calendars#index'
  end
  # devise_for :users

  devise_for :users, controllers: {
  registrations: 'users/registrations',
  sessions: 'users/sessions'
}

devise_scope :user do
  authenticated :user do
    root 'dashboard#index', as: :authenticated_root
  end

  unauthenticated do
    root 'devise/sessions#new', as: :unauthenticated_root
  end
end

  root "home#public_page"

  
  
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # # Defines the root path route ("/")
  #  authenticated :user do
  #   root to: 'dashboard#index', as: :user_root
  # end
  

  post '/send_email_test', to: 'home#send_email_test'


  resources :athlete_profiles, only: [:new, :create, :index ,:show ,:edit, :update]
  # get '/athlete_users/:id' , to: 'athlete_profiles#athlete_users'
  get 'athlete_users/autocomplete', to: 'athlete_profiles#autocomplete'
  get 'users' , to: 'users#index'
  get 'users/:id' , to: 'users#show'
  get'goals_rewards_achievements', to: 'dashboard#goals_rewards_achievements'
  post '/checklist_items', to: 'athlete_profiles#checked_items'


  #Accounts
  resources :accounts, only: [:new, :create, :index ,:show ,:edit, :update] do
  get 'all_accounts', on: :collection, to: 'accounts#all_accounts'
  post 'create_child_user', on: :collection, to: 'accounts#create_child_user'
  end

  resources :notifications, only: [:index, :show, :update] do
    post 'set_viewed', on: :collection 
  end

  resources :questionnaires, only: [:index, :show, :new, :create, :edit, :update, :destroy] do
    get 'reports', on: :collection
  end

  resources :taster_session_bookings, only: [:index] 

  resources :answers, only: [:create]

  #QR Code generation
  resources :qr_codes, only: [:new, :create, :index, :show]
  get 'qr_code_generation', to: 'qr_codes#index'
  get 'scanner' , to: 'qr_codes#scanner'

  #search 
  post 'search' , to: 'search#index', as: 'search'
  post 'search/suggestions' , to: 'search#suggestions', as: 'search_suggestions'

  #Kpi routes
  get '/kpis', to: "kpi#index"
  post '/kpis_create', to: "kpi#create"
  delete '/kpis/:id', to: "kpi#destroy"
  get 'kpis/:id/edit', to: "kpi#edit", as: 'edit_kpi'
  patch '/kpis/:id/edit', to: "kpi#update", as: 'update_kpi'


  get '/dashboard' , to: "dashboard#index"
  get '/subscriptions', to: "home#subscriptions"

  # Edit user
  get 'users/edit_user/:id', to: "users#edit_user", as: 'edit_user'
  patch 'users/update_user/:id', to: "users#update_user", as: 'update_user'
  delete '/delete_user/:id', to: "users#delete_user"


  #  API ROUTES 

  namespace :api do
    namespace :v1 do
      resources :taster_session_bookings , only: [:create]
      
      #auth routes
      resources :auth do
        post 'login' , on: :collection, to: 'auth#login'
        post 'sign-up' , on: :collection, to: 'auth#sign_up'
        post 'check_token', on: :collection, to: 'auth#check_token'
      end
    end
  end

end