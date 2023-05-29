Rails.application.routes.draw do

  devise_for :users
  root to: "homes#top"
  get "homes/about" => "homes#about", as: "about"
  post 'books' => 'books#create'
  resources :books, only: [:index, :show, :edit, :update, :destroy]
  resources :users, only: [:index, :show, :edit, :update]
end
