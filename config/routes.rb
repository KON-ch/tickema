Rails.application.routes.draw do
  # https://guides.rubyonrails.org/routing.html

  root to: 'top#index'

  devise_for :users, skip: %i[registrations passwords]

  resources :stages, only: %i[show]
  resources :schedules, only: %i[create]
  resources :customers, only: %i[create]
  resources :tickets, only: %i[create update destroy]
  resources :contacts, only: %i[update]

  get '/mypage', to: 'users#show'
end
