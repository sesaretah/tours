Rails.application.routes.draw do

  devise_for :users, :controllers => {:registrations => "registrations", sessions: "sessions"}
  resources :agencies
  resources :tour_packages
  resources :tours
  resources :uploads
  root "home#index"

  get 'settings/index'
  get "settings/sections" => "settings#sections"
  get '/settings', to: "settings#index"

  post '/airlines', to: "airlines#create"
  post '/railways', to: "railways#create"
  post '/hotels', to: "hotels#create"
  post '/price_types', to: "price_types#create"

  get '/uploads/remoted/:id', to: "uploads#remoted"
  get '/tour_packages/upload/:id', to: "tour_packages#upload"
end
