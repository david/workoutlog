Rails.application.routes.draw do
  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  resources :training_sessions, param: :session_on, only: %i[index show] do
    resources :exercise_choices

    member do
      get "exercises/:exercise_id", to: "training_sessions#show",
        as: :exercise
    end
  end

  resources :exercises do
    resources :exercise_options, only: %i[new create]
  end

  resource :authentication, only: %i[new create show]

  get "sessions/create", to: "sessions#create", as: :create_session

  # Defines the root path route ("/")
  root "training_sessions#index"
end
