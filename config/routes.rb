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
  resources :users
  resources :buyers
  resources :vouchers
  resources :tags
  

  resources :foods do
    resources :reviews
  end
  resources :restaurants do
    resources :reviews
  end
  
  resources :reviews
  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
