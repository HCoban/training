Rails.application.routes.draw do
  resources :users, except: :index
  resource :session, only: [:new, :create, :destroy]
  resources :subs
  resources :posts, except: :index

  root to: "subs#index"
end
