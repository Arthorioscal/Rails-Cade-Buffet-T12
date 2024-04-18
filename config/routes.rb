Rails.application.routes.draw do
  devise_for :users, :controllers => {:registrations => "registrations"}

  root to: "home#index"

  resources :buffets, only: %i[index show new create edit update]
  resources :events, only: %i[index show new create edit update]

  get "up" => "rails/health#show", as: :rails_health_check
end
