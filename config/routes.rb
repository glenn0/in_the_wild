InTheWild::Application.routes.draw do
  root "pages#home"    
  get "home", to: "pages#home", as: "home"
  
    
  devise_for :users
  
  namespace :admin do
    root "base#index"
    resources :users
  end

  resources :pages, only: [:new]
  resources :projects, only: [:create]
  
end
