Rails.application.routes.draw do
  
  resources :authors, only: [:show, :create]
  resources :posts, only: [:show, :update]
  
end
