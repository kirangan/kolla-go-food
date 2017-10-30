Rails.application.routes.draw do
  resources :carts
  resources :line_items
  root 'store#index', as: 'store_index'
  resources :foods
  resources :categories
  get 'home/hello'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
