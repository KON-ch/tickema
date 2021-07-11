Rails.application.routes.draw do
  # https://guides.rubyonrails.org/routing.html

  root 'top#index'
  resources :stages, except: %i[new edit]
  resources :schedules, only: :create
  resources :customers, except: %i[new edit]
end
