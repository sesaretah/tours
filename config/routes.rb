Rails.application.routes.draw do
  devise_for :users
  resources :agencies
  resources :tour_packages
  resources :tours
 root "home#index"
end
