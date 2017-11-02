Rails.application.routes.draw do
  resources :carts
  resources :line_items
  resources :categories
  resources :orders
  resources :foods
  root 'store#index', as: 'store_index'
  get 'home/hello'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
