Rails.application.routes.draw do
  devise_for :users, :skip => [:registrations] 
  as :user do
    get 'users/edit' => 'devise/registrations#edit', :as => 'edit_user_registration'
    put 'users' => 'devise/registrations#update', :as => 'user_registration'
  end

  namespace :admin do
    resources :users do
      resources :dogs
    end
  end
  
  resources :services
  
  resources :turn_forms do
    member do
      patch 'confirm'
      patch 'reject'
      get 'emit_amount'
      post 'save_amount'
    end
  end  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  root "home#index"
end
