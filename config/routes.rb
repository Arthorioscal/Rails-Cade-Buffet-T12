Rails.application.routes.draw do
  devise_for :users, :controllers => {:registrations => "registrations"}

  devise_scope :user do
    get '/users/choose_role', to: 'registrations#choose_role', as: :choose_role
    get '/users/sign_up/buffet_owner', to: 'registrations#new_buffet_owner', user: { role: 'buffet_owner' }, as: :new_buffet_owner_registration
    get '/users/sign_up/client', to: 'registrations#new_client', user: { role: 'client' }, as: :new_client_registration
  end

  root to: "home#index"

  resources :buffets, only: %i[index show new create edit update]
  resources :events, only: %i[index show new create edit update]
  resources :event_prices, only: %i[show new create edit update]

  get "up" => "rails/health#show", as: :rails_health_check
end
