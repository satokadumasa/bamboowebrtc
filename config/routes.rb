Rails.application.routes.draw do
  get 'welcome/index'
  mount ActionCable.server, at: '/cable'
  root to: 'welcome#index'
  resources :rooms
  # resources :rooms, only: %i[show]
  resources :user_infos
  resources :cities
  resources :prefs

  devise_for :users, controllers: {
    sessions: 'users/sessions'
  }
  # token auth routes available at /api/v1/auth

  devise_scope :user do
    get "/sign_in", :to => "users/sessions#new"
    get "/sign_out", :to => "users/sessions#destroy"
    get "/confirmation", :to => "users/confirmations#show"
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
