Rails.application.routes.draw do
  # https://guides.rubyonrails.org/routing.html

  root 'top#index'
  resources :stages
end
