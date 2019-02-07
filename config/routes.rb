Rails.application.routes.draw do

  resources :blogs
  resources :passengers
  devise_for :users, :controllers => {:registrations => "registrations", sessions: "sessions"}
  resources :agencies
  resources :tour_packages
  resources :tours
  resources :uploads
  resources :blogs
  resources :access_controls


  get '', to: 'home#index', constraints: lambda { |r| r.subdomain.present? && r.subdomain != 'www' }
  root "home#index"

  get 'settings/index'
  get "settings/sections" => "settings#sections"
  get '/settings', to: "settings#index"

  post '/airlines', to: "airlines#create"
  post '/railways', to: "railways#create"
  post '/buses', to: "buses#create"
  post '/hotels', to: "hotels#create"
  post '/price_types', to: "price_types#create"

  get '/uploads/remoted/:id', to: "uploads#remoted"
  get '/tour_packages/upload/:id', to: "tour_packages#upload"

  get '/railways/options', to: "railways#options"
  get '/airlines/options', to: "airlines#options"
  get '/buses/options', to: "buses#options"

  get '/reservations/new', to: "reservations#new"
  get '/reservations/passengers', to: "reservations#passengers"
  get '/reservations/verification', to: "reservations#verification"
  get '/reservations/:id/destroy', to: "reservations#destroy"

  get '/tour_packages/check/:id', to: "tour_packages#check"
  get '/tour_packages/change_rank/:id', to: "tour_packages#change_rank"
  get '/tour_packages/change_status/:id', to: "tour_packages#change_status"

  get '/blogs/check/:id', to: "blogs#check"
  get '/blogs/change_rank/:id', to: "blogs#change_rank"

  get '/landing', to: "home#landing"

  post '/roles', to: "roles#create"
  get '/roles/:id/destroy', to: "roles#destroy"
  get '/roles/access/:id', to: "roles#access"
  get '/roles/change_current_role', to: "roles#change_current_role"

  post '/assignments', to: "assignments#create"
  get '/assignments/:id/destroy', to: "assignments#destroy"

  post '/provinces', to: "provinces#create"
  get '/provinces/:id/destroy', to: "provinces#destroy"

  get '/api/tour_packages', to: "api#tour_packages"
  get '/api/tour_package/:id', to: "api#tour_package"
  get '/api/tour/:id', to: "api#tour"
  get '/api/login', to: "api#login"
  get '/api/tour_reservations/:id', to: "api#tour_reservations"


  post '/api/sign_up', to: "api#sign_up"
  post '/api/reservation', to: "api#reservation"
end
