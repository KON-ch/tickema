Rails.application.routes.draw do
  # https://guides.rubyonrails.org/routing.html

  root to: 'top#index'

  devise_for :users, skip: %i[registrations passwords]

  resources :stages, only: %i[index show]

  resources :customers, only: %i[index update]
  resources :tickets, only: %i[create destroy]

  resources :reservations, only: %i[create] do
    patch :count
    patch :status
  end

  get '/mypage', to: 'users#show'
end
