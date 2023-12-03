Rails.application.routes.draw do
  devise_for :users, :skip => [:registrations], :path_prefix => 'my'
  as :user do
    get 'my/users/edit' => 'devise/registrations#edit', :as => 'edit_user_registration'
    put 'my/users' => 'devise/registrations#update', :as => 'user_registration'
  end

  resources :users, shallow: true do
    resources :dogs do
      resources :clinic_dogs
    end
  end

  resources :adoption_posts

  resources :meetings
  
  resources :services do
    member do
      patch 'toggle_state'
    end
  end
  
  resources :turn_forms do
    member do
      patch 'confirm'
      patch 'reject'
      patch 'cancel'
      get 'emit_amount'
      post 'save_amount'
    end
  end

  resources :notifications, only: [:index]
  
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  root "home#index"
end
