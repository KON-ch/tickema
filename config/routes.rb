Rails.application.routes.draw do
  # https://guides.rubyonrails.org/routing.html

  root to: 'top#index'

  devise_for :users, skip: %i[registrations passwords]

  resources :stages, only: %i[index show]

  resources :customers, only: %i[index update]
  resources :tickets, only: %i[create destroy]

  patch "reservations/:id/count" => "reservations#count"
  patch "reservations/:id/status" => "reservations#status"

  get '/mypage', to: 'users#show'
end
