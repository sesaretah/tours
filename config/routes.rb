Rails.application.routes.draw do
  get 'settings/index'
  get '/settings', to: "settings#index"

  devise_for :users, :controllers => {:registrations => "registrations", sessions: "sessions"}
  resources :agencies
  resources :tour_packages
  resources :tours
  resources :uploads
  root "home#index"

  get '/uploads/remoted/:id', to: "uploads#remoted"
  get '/tour_packages/upload/:id', to: "tour_packages#upload"
end
