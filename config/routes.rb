Rails.application.routes.draw do
  # https://guides.rubyonrails.org/routing.html

  root to: 'top#index'

  devise_for :users, skip: %i[registrations passwords]

  resources :stages, only: %i[show]

  resources :customers, only: %i[index update]

  resources :reservations, only: %i[create destroy] do
    patch :count
    patch :status
  end

  get '/mypage', to: 'users#show'
end
