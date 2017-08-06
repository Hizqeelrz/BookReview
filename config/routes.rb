Rails.application.routes.draw do

  devise_for :users
  resources :book_categories
  resources :books
  root "books#index"

end
