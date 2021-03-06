Rails.application.routes.draw do
  get 'admin' => 'admin#index'

  get 'home/hello'
  root 'store#index', as: 'store_index'

  controller :sessions do
    get 'login' => :new
    post 'login' => :create
    delete 'logout' => :destroy
  end

  resources :carts
  resources :line_items
  resources :categories
  resources :orders
  resources :foods
  resources :users
  resources :buyers
  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
