# frozen_string_literal: true

require 'sidekiq/web'

Rails.application.routes.draw do
  resources :competitions
  resources :athlete_level_categories
  resources :step_exercises
  resources :exercises do
    collection do
      post :bulk_exercise_upload
    end
  end
  resources :steps
  mount Sidekiq::Web => '/sidekiq'

  # Common Routes
  resources :dcpa_events
  resources :time_slots
  resources :coach_calendar, only: %i[index create update destroy show] do
    get 'data/:user_id', on: :collection, to: 'coach_calendar#calendar_data'
    get 'data', on: :collection, to: 'coach_calendar#all_calendars'
    get 'coach_calendar/:user_id', on: :collection, to: 'coach_calendars#show'
    get 'coach_calendar', on: :collection, to: 'coach_calendars#index'
  end

  # Devise Routes
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

  # Health Check Route
  get 'up' => 'rails/health#show', as: :rails_health_check

  # Onboarding & Other Routes
  get 'onboarding', to: 'onboarding#index'
  post '/send_email_test', to: 'home#send_email_test'

  # Shared Athlete Profile Routes
  resources :athlete_profiles, only: %i[new create index show edit update]
  get 'athlete_users/autocomplete', to: 'athlete_profiles#autocomplete'
  get 'users', to: 'users#index'
  get 'users/:id', to: 'users#show'
  get 'goals_rewards_achievements', to: 'dashboard#goals_rewards_achievements'
  post '/checklist_items', to: 'athlete_profiles#checked_items'
  post '/kpi_csv_upload', to: 'dashboard#kpi_csv_upload'

  # Review Routes
  resources :reviews

  # Accounts Routes
  resources :accounts, only: %i[new create index show edit update] do
    get 'all_accounts', on: :collection, to: 'accounts#all_accounts'
    get 'add_child', on: :collection, to: 'accounts#add_child'
    post 'create_child_user', on: :collection, to: 'accounts#create_child_user'
  end

  # Notification Routes
  resources :notifications, only: %i[index show update] do
    post 'set_viewed', on: :collection
  end

  # Questionnaire Routes
  resources :questionnaires, only: %i[index show new create edit update destroy] do
    get 'reports', on: :collection
  end

  # Booking Routes
  resources :taster_session_bookings, only: [:index]
  resources :answers, only: [:create]

  # Tracking & Achievements Routes
  resources :athlete_tracking, only: [:index]
  resources :achievements, only: [:index]
  resources :skill_builder_hub, only: [:index]

  # QR Code Routes
  resources :qr_codes, only: %i[new create index show]
  get 'qr_code_generation', to: 'qr_codes#index'
  get 'scanner', to: 'qr_codes#scanner'

  # Search Routes
  post 'search', to: 'search#index', as: 'search'
  post 'search/suggestions', to: 'search#suggestions', as: 'search_suggestions'

  # KPI Routes
  get '/kpis', to: 'kpi#index'
  get '/kpis/new', to: 'kpi#new', as: 'new_kpi'
  post '/kpis_create', to: 'kpi#create', as: 'kpis_create'
  delete '/kpis/:id', to: 'kpi#destroy'
  get 'kpis/:id/edit', to: 'kpi#edit', as: 'edit_kpi'
  patch '/kpis/:id/edit', to: 'kpi#update', as: 'update_kpi'
  post '/kpis/bulk_delete', to: 'kpi#bulk_delete', as: 'bulk_delete'

  # Dashboard Routes
  get '/dashboard', to: 'dashboard#index'
  get '/subscriptions', to: 'home#subscriptions'

  # User Edit Routes
  get 'users/edit_user/:id', to: 'users#edit_user', as: 'edit_user'
  get 'users/edit/:id', to: 'users#edit', as: 'edit'
  patch 'users/update_user/:id', to: 'users#update_user', as: 'update_user'
  delete '/delete_user/:id', to: 'users#delete_user'

  # Admin API Routes
  namespace :api do
    namespace :v1 do
      resources :taster_session_bookings, only: [:create]
      resources :auth do
        post 'login', on: :collection, to: 'auth#login'
        post 'sign-up', on: :collection, to: 'auth#sign_up'
        post 'check_token', on: :collection, to: 'auth#check_token'
      end
      resources :questions, only: [:index]
    end

    namespace :v2 do
      resources :forms, only: %i[index create show]
      resources :training_packages, only: [:index]
      resources :training_bookings, only: %i[index create]
      resources :dcpa_events, only: [:index]
    end
  end

  # Parent Routes
  namespace :parents do
    resources :dashboard, only: [:index]
    resources :profiles, only: %i[show edit update]
    resources :messages, only: %i[index show create]
    resources :billing, only: %i[index show]
    resources :resources, only: [:index]
  end

  # Child Routes
  namespace :juniors do
    resources :profiles, only: [:show]
    resources :training, only: %i[index show]
    resources :achievements, only: %i[index show]
    resources :learning, only: %i[index show]
    resources :dashboard, only: [:index]
  end

  # Adult Athlete Routes
  namespace :athletes do
    resources :performance, only: [:index]
    resources :training_plans, only: %i[index show]
    resources :goals, only: %i[index show]
    resources :feedback, only: %i[index show]
    resources :dashboard, only: [:index]
  end

  # Coach Routes
  namespace :coaches do
    resources :dashboard, only: [:index]
    resources :athletes, only: %i[index show]
    resources :sessions, only: %i[new create index]
    resources :assessments do
      post 'get-kpis', on: :collection, to: 'assessments#get_kpis'
    end
    resources :messages, only: %i[index show create]
  end

  # Admin Routes
  namespace :admins do
    resources :users, only: %i[index create update destroy]
    resources :academy, only: [:index]
    resources :reports, only: [:index]
    resources :content, only: %i[index edit update]
    resources :billing, only: %i[index show]
  end

  resources :kpi_categories
  resources :athlete_levels
  resources :attendance, only: %i[index create]

  namespace :admin do
    resources :dashboard, only: [:index]
    resources :content, only: %i[index edit update]
    resources :taster_booking, only: %i[index show new create edit update destroy]
    resources :assessment, only: %i[index]
  end
  post 'assessments/create', to: 'coaches/assessments#create', as: 'create_assessment'

  resources :app_errors, only: %i[index show destroy]
  post 'accounts/search_accounts', to: 'accounts#search_accounts', as: 'search_accounts'
end
