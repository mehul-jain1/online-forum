Rails.application.routes.draw do
  root to: 'questions#index'
  devise_for :users
  
  resources :users

  resources :questions do
    resources :comments
  end
  
  resources :comments do
    resources :comments 
  end

end
