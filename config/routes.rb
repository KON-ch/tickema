Rails.application.routes.draw do
  # https://guides.rubyonrails.org/routing.html

  root to: 'top#index'

  devise_for :users, skip: %i[registrations passwords]

  resources :stages, except: %i[new edit]
  resources :schedules, only: :create
  resources :customers, except: %i[new edit]
  resources :stage_schedules, only: :show

  get '/mypage', to: 'users#show'
end
