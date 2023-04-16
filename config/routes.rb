Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "home#index"
  
  resources :tweets, only: [:show, :create] do
    resources :bookmarks, only: [:create, :destroy]
    resources :likes, only: [:create, :destroy]
    resources :retweets, only: [:create, :destroy]
    resources :reply_tweets, only: :create
  end

  get :dashboard, to: "dashboard#index"
  get :profile, to: "profiles#show"
  put :profile, to: "profiles#update"

  resources :usernames, only: [:new, :update]
end
