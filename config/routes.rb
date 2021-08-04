Rails.application.routes.draw do
  # https://guides.rubyonrails.org/routing.html

  root to: 'top#index'

  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions:      'users/sessions',
  }

  resources :stages, except: %i[new edit]
  resources :schedules, only: :create
  resources :customers, except: %i[new edit]
  resources :stage_schedules, only: :show
end
