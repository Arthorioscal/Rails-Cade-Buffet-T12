Rails.application.routes.draw do
  devise_for :users, :controllers => {:registrations => "registrations"}

  devise_scope :user do
    get '/users/choose_role', to: 'registrations#choose_role', as: :choose_role
    get '/users/sign_up/buffet_owner', to: 'registrations#new_buffet_owner', user: { role: 'buffet_owner' }, as: :new_buffet_owner_registration
    get '/users/sign_up/client', to: 'registrations#new_client', user: { role: 'client' }, as: :new_client_registration
  end

  root to: "home#index"

  resources :buffets, only: %i[show new create edit update] do
    member do
      post :toggle_active
    end
    
    resources :buffet_orders, only: %i[index show]

    get 'profile', to: 'buffets#profile'
    get 'search', to: 'buffets#search', on: :collection
  end
  
  resources :events, only: %i[index show new create edit update] do
    member do
      post :toggle_active
    end
  end

  resources :orders, only: %i[index show new create edit update] do
    resources :messages, only: %i[create]
    
    member do
      get :buffet_confirmation_form
      patch :buffet_confirmation
      patch :client_confirmation
    end
  end

  resources :event_prices, only: %i[show new create edit update]

  namespace :api do
    namespace :v1 do
      resources :buffets, only: %i[index show] do
        resources :events, only: %i[index] do
          get 'availability', on: :member
        end
      end
    end
  end

  get "up" => "rails/health#show", as: :rails_health_check
end
