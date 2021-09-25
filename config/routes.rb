Rails.application.routes.draw do
  # https://guides.rubyonrails.org/routing.html

  root to: 'top#index'

  devise_for :users, skip: %i[registrations passwords]

  resources :stages, except: %i[new edit]
  resources :schedules, only: :create
  resources :customers, except: %i[new edit]
  put '/customers/:id/data', to: 'customers#data'
  get '/customers/:id/csv', to: 'customers#csv'

  get '/mypage', to: 'users#show'
end
