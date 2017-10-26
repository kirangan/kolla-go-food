Rails.application.routes.draw do
  get 'store/index'

  resources :buyers
  resources :foods
  resources :stores
  get 'home/goodbye'

  get 'home/hello'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
