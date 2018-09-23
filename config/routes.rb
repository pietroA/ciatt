Rails.application.routes.draw do
  root 'pages#index'

  mount ActionCable.server => '/cable'
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
  
  get    '/signup',  to: 'users#new'

  resources :users
  resources :chats
  namespace :api do
    resources :chat_users
    resources :messages
    resources :users
    resources :chats
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
