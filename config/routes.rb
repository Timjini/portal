# frozen_string_literal: true

require 'sidekiq/web'

Rails.application.routes.draw do
  mount Sidekiq::Web => '/sidekiq'

  resources :dcpa_events
  resources :time_slots
  resources :coach_calendar, only: %i[index create update destroy show] do
    get 'data/:user_id', on: :collection, to: 'coach_calendar#calendar_data'
    get 'data', on: :collection, to: 'coach_calendar#all_calendars'
    get 'coach_calendar/:user_id', on: :collection, to: 'coach_calendars#show'
    get 'coach_calendar', on: :collection, to: 'coach_calendars#index'
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

  root 'home#public_page'

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get 'up' => 'rails/health#show', as: :rails_health_check

  # # Defines the root path route ("/")
  #  authenticated :user do
  #   root to: 'dashboard#index', as: :user_root
  # end

  get 'onboarding', to: 'onboarding#index'
  post '/send_email_test', to: 'home#send_email_test'

  resources :athlete_profiles, only: %i[new create index show edit update]
  # get '/athlete_users/:id' , to: 'athlete_profiles#athlete_users'
  get 'athlete_users/autocomplete', to: 'athlete_profiles#autocomplete'
  get 'users', to: 'users#index'
  get 'users/:id', to: 'users#show'
  get 'goals_rewards_achievements', to: 'dashboard#goals_rewards_achievements'
  post '/checklist_items', to: 'athlete_profiles#checked_items'
  post '/kpi_csv_upload', to: 'dashboard#kpi_csv_upload'

  resources :reviews

  # Accounts
  resources :accounts, only: %i[new create index show edit update] do
    get 'all_accounts', on: :collection, to: 'accounts#all_accounts'
    get 'add_child', on: :collection, to: 'accounts#add_child'
    post 'create_child_user', on: :collection, to: 'accounts#create_child_user'
  end

  resources :notifications, only: %i[index show update] do
    post 'set_viewed', on: :collection
  end

  resources :questionnaires, only: %i[index show new create edit update destroy] do
    get 'reports', on: :collection
  end

  resources :taster_session_bookings, only: [:index]

  resources :answers, only: [:create]

  resources :qr_codes, only: %i[new create index show]
  get 'qr_code_generation', to: 'qr_codes#index'
  get 'scanner', to: 'qr_codes#scanner'

  post 'search', to: 'search#index', as: 'search'
  post 'search/suggestions', to: 'search#suggestions', as: 'search_suggestions'

  get '/kpis', to: 'kpi#index'
  post '/kpis_create', to: 'kpi#create'
  delete '/kpis/:id', to: 'kpi#destroy'
  get 'kpis/:id/edit', to: 'kpi#edit', as: 'edit_kpi'
  patch '/kpis/:id/edit', to: 'kpi#update', as: 'update_kpi'
  post '/kpis/bulk_delete', to: 'kpi#bulk_delete', as: 'bulk_delete'

  get '/dashboard', to: 'dashboard#index'
  get '/subscriptions', to: 'home#subscriptions'

  # Edit user
  get 'users/edit_user/:id', to: 'users#edit_user', as: 'edit_user'
  get 'users/edit/:id', to: 'users#edit', as: 'edit'
  patch 'users/update_user/:id', to: 'users#update_user', as: 'update_user'
  delete '/delete_user/:id', to: 'users#delete_user'

  #  API ROUTES

  namespace :api do
    namespace :v1 do
      resources :taster_session_bookings, only: [:create]
      resources :auth do
        post 'login', on: :collection, to: 'auth#login'
        post 'sign-up', on: :collection, to: 'auth#sign_up'
        post 'check_token', on: :collection, to: 'auth#check_token'
      end
    end
  end

  namespace :api do
    namespace :v2 do
      resources :forms, only: %i[index create show]
      resources :training_packages, only: [:index]
      resources :training_bookings, only: %i[index create]
      resources :dcpa_events, only: [:index]
    end
  end
end
