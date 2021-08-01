Rails.application.routes.draw do
  # https://guides.rubyonrails.org/routing.html

  root to: 'top#index'

  devise_for :users, skip: :all

  devise_scope :user do
    get 'sign_in', to: 'users/sessions#new'
    get 'login',   to: 'users/sessions#new'
    get 'logout',  to: 'users/sessions#destroy'
  end

  resources :stages, except: %i[new edit]
  resources :schedules, only: :create
  resources :customers, except: %i[new edit]
  resources :stage_schedules, only: :show
end
